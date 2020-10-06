
### Protect the Docker daemon socket

By default, Docker runs through a non-networked UNIX socket. It can also optionally communicate using an HTTP socket, often used by orchestration engines.  If you need Docker to be reachable through the network in a safe manner, you can enable TLS by specifying the tlsverify flag and pointing Docker’s tlscacert flag to a trusted CA certificate.

We will now show how to setup the runtime to use 2 2ay authenication and enforcing the principle of least privilege by restricting access to the daemon and encrypting the communication protocols

### Advanced Topic: Create a CA, server and client keys with OpenSSL
Using TLS and managing a CA is an advanced topic. Please familiarize yourself with OpenSSL, x509, and TLS before using it in production. We will now setup the runtime to use 2

1 Generate the CA's private & public keys on the Docker Daemon's host machine

For simplicity we are are entering the CA passphrase 'INSECURE_PASS_123' through the commandline. Passing in sensitive information through the commandline should be avoided and replaced by a more secure method like using a key vault or environment variable in non demo environments

1 Generate public key
`export HOST=401_docker_host && export IP=127.0.1.1 && openssl req \
-subj "/C=US/ST=NRW/L=SanFrancisco/O=401_Inc/OU=DevOps/CN=my.401example.com/emailAddress=401@my_containersecurity.com" \
-new -x509 -days 365 -keyout ca-key.pem -sha256 -passout pass:INSECURE_PASS_123 -out ca.pem`{{execute}}

2a Generate Server private Key
`openssl genrsa -out server-key.pem 4096`{{execute}}

2b Create the Certificate Signing Request (CSR)
`openssl req -subj "/CN=$HOST" -sha256 -new -key server-key.pem -out server.csr`{{execute}}

3 Sign the public key with our CA.

When asked for the CA passphrase, enter: INSECURE_PASS_123

```
# IP address needs to be specified when creating the cert
# set the host and IP by the DNS of the Dockers daemon
echo subjectAltName = DNS:$HOST, IP:$IP,IP:127.0.0.1 >> extfile.cnf
# Set the Docker Daemon's key exented usage attributes to be used for server auth only
echo extendedKeyUsage = serverAuth >> extfile.cnf
# Generate the signed certificate by our CA
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf
```{{execute}}

4. Protect the private keys and certs
```
# Private keys readonly
chmod -v 0400 ca-key.pem server-key.pem
# Certs worldwide, remove write access
chmod -v 0444 ca.pem server-cert.pem
```{{execute}}


5 Update Docker daemon to only accept authenticated connections from clients providing a certificate trusted by the CA

We will run restart the daemon and tell it to use our CA cert in a new Terminal window:
```
service docker stop
dockerd --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem -H=0.0.0.0:2376
```{{execute T2}}

Lets now create our client cert in a new terminal, sign it with the CA key:

6 Create Client Certificate

When asked for the CA passphrase, enter the same CA passphrase again: INSECURE_PASS_123
```
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
echo extendedKeyUsage = clientAuth > extfile-client.cnf
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile-client.cnf
```{{execute T3}}

## Verify that now only signed requests are allowed

Keep an eye on Terminal 2, the docker daemon’s host, which shows the logs of the connection attempt

7 See Docker client call failing without the certificate
` export HOST=127.0.0.1 && docker -v -H=$HOST:2376 ps `{{execute T3}}

8 Now perform the same call with the certs
` export HOST=127.0.0.1 && docker -v --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem -H=$HOST:2376 ps `{{execute T3}}

9 Another client call but now using environment vars instead cmd line args:
```
mkdir -pv ~/.docker
cp -v {ca,cert,key}.pem ~/.docker
export DOCKER_HOST=tcp://$HOST:2376 DOCKER_TLS_VERIFY=1
docker ps
```{{execute T3}}

10 Client call with CURL
`curl https://$HOST:2376/version --cert ~/.docker/cert.pem --key ~/.docker/key.pem --cacert ~/.docker/ca.pem | jq .`{{execute T3}}

11 Finally see curl fail without cert
`export HOST=127.0.0.1 && curl https://$HOST:2376/version | jq . `{{execute T3}}

# Bonus

### Other modes

There are various other modes of operation, listed below. You are encouraged to explore the different modes of operation.

In the daemon mode, it only allows connections from clients authenticated by a certificate signed by that CA.
In the client mode, it only connects to servers with a certificate signed by that CA.

If you don’t want to have complete two-way authentication, you can run Docker in various other modes by mixing the flags.
Daemon modes

    tlsverify, tlscacert, tlscert, tlskey set: Authenticate clients
    tls, tlscert, tlskey: Do not authenticate clients

Client modes

    tls: Authenticate server based on public/default CA pool
    tlsverify, tlscacert: Authenticate server based on given CA
    tls, tlscert, tlskey: Authenticate with client certificate, do not authenticate server based on given CA
    tlsverify, tlscacert, tlscert, tlskey: Authenticate with client certificate and authenticate server based on given CA

If found, the client sends its client certificate, so you just need to drop your keys into ~/.docker/{ca,cert,key}.pem. Alternatively, if you want to store your keys in another location, you can specify that location using the environment variable DOCKER_CERT_PATH.

```sh
$ export DOCKER_CERT_PATH=~/.docker/zone1/
$ docker --tlsverify ps
```
