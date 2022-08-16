require 'sinatra'
require 'socket'


get '/' do
    %{Hello from host: #{Socket.gethostname}!!
    
    
    #{File.read("results.txt")}}
end