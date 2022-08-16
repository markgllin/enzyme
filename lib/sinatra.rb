require 'sinatra'
require 'socket'

set :port, 80
set :bind, '0.0.0.0'

get '/' do
    %{Hello from host: #{Socket.gethostname}!!
    
    
    #{File.read("results.txt")}}
end