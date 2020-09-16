This is your first step.

## Task

This is an _example_ of creating a scenario and running a **command**

## Copy to Clipboard
`echo 'Hello World'`{{execute}}

`echo "Copy to Clipboard"`{{copy}}Results: echo "Copy to Clipboard

## Copy multilines to clipboard

```
echo "Line 1"

echo "Line 2"

echo "Line 3"
```{{copy}}

## Run in Terminal
`echo "ls -al"`{{execute}}

## Multline in Terminal
```
echo "Line 1"

echo "Line 2"

echo "Line 3"
```{{execute}}


## Interrupt
When the user has long running commands, such as top, it can be useful to ensure that this is stopped but the user runs the next command.
`echo "Send Ctrl+C before running Terminal"`{{execute interrupt}}echo "Send Ctrl+C before running Terminal"

## Control Sequences
Alongside the interrupt command above, certain Control Sequences can be sent.
Given a long running command, like top. It can be stopped using +. This can be executed as a control sequence with the command ^C

The markdown for this is:
`^C`{{execute ctrl-seq}}

The use of control sequences can be useful when teaching applications such as vim.
The instructions can guide the user on how
• Switch to insert mode by typing i

• Once finished, press ESC (^ESC) to switch back to normal mode

• To exit, type :q!

In the markdown, you would include:
`i`{{execute no-newline}}

`^ESC`{{execute ctrl-seq}}

`:q!`{{execute}}
Notice the use of no-newline as a way to send a keystroke with a carriage return following it.

## Keyboard Icons
This can also be helped by using Keyboard symbols to show users to use
+The Markdown is:
<kbd>Ctrl</kbd>+<kbd>C</kbd>

## Execute on different hosts
When using the terminal-terminal layout and multiple  hosts within the cluster, you can have commands executed on which host  is required. This is used within our Kubernetes scenarios.

`echo "Run in Terminal Host 1"`{{execute HOST1}}
`echo "Run in Terminal Host 2"`{{execute HOST2}}
echo "Run in Terminal Host 1"
echo "Run in Terminal Host 2"

## Execute in different Terminal windows
When explaining complex systems, it can be useful to run commands in a  separate terminal window. This can be run automatically by including  the target Terminal number.  If the terminal is not open, it will launch and the command will be executed.

`echo "Run in Terminal 3"`{{execute T3}}
`echo "Open and Execute in Terminal 4"`{{execute T4}}

echo "Run in Terminal 3"
echo "Open and Execute in Terminal 4"
