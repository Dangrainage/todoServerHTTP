require 'webrick'
include WEBrick

byteLimit = 24

serverPort = 8989

userName = "user"
password = "testpass"

currentTime = Time.now.strftime("%H:%M:%S")

if password.size > byteLimit
  puts "Password too long! Please choose a shorter password"
  exit(1)
end


tasksLines = File.read("TODO.txt")

server = HTTPServer.new(:Port => serverPort)


server.mount_proc '/' do |request, response|
  request.each { |header, value| puts "  #{header}: #{value}" }


    if "#{request.body}".to_s == "#{userName} #{password}"
      response.status = 200
      response['Content-Type'] = 'text/plain'
      response.body = "Hello #{userName} \n" + "It's #{currentTime} now \n \nYour tasks are: \n"  + tasksLines 
    else
      response.status = 401
      response['Content-Type'] = 'text/plain'
      response.body = "Username or password incorrect. Please check your spelling and try again. \n"
    end
end


trap('INT') {server.shutdown}
server.start
