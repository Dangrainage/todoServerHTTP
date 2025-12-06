# todoServerHTTP
A small ToDo server written in ruby. Usable (and made for use) with curl.

# Usage

Write your tasks to a `TODO.txt` file that should be in the same directory as the server itself.
After that just simply run the server using ruby. `ruby todoServerHTTP.rb`

Client side, you should use curl to request your tasks like so `curl -d "<username> <password>" your.server.address`
Ofcouse replacing the placeholders with your actual username, password and server address (don't forget to change the defaults!)

Enjoy!
