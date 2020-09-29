# Export the sha256sum for verification.
export BANE_SHA256="69df3447cc79b028d4a435e151428bd85a816b3e26199cd010c74b7a17807a05"

# Download and check the sha256sum.
curl -fSL "https://github.com/genuinetools/bane/releases/download/v0.4.4/bane-linux-amd64" -o "/usr/local/bin/bane" \
	&& echo "${BANE_SHA256}  /usr/local/bin/bane" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/bane"

git clone https://github.com/genuinetools/bane.git

echo "bane installed!"

# Run it!
bane -h
