require 'webrick'
include WEBrick

tasksLines = nil
byteLimit = 24

serverPort = 8989

userName = "user"
password = "testpass"

currentTime = Time.now.strftime("%H:%M:%S")

if password.size > byteLimit or userName.size > byteLimit
  puts "Password or username too long! Please check that neither are longer than 24 characters!"
  exit(1)
end



server = HTTPServer.new(:Port => serverPort)


server.mount_proc '/' do |request, response|
  request.each { |header, value| puts "  #{header}: #{value}" }


    if "#{request.body}".to_s == "#{userName} #{password}"
      tasksLines = File.read("TODO.txt")
      response.status = 200
      response['Content-Type'] = 'text/plain'
      response.body = "Hello #{userName} \n" + "It's #{currentTime} now \n \nYour task(s) are: \n"  + tasksLines 
    else
      response.status = 401
      response['Content-Type'] = 'text/plain'
      response.body = "Username or password incorrect. Please check your spelling and try again. \n"
    end
        
end


trap('INT') {server.shutdown}
server.start
