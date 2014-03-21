require 'sinatra/base'

class OnsFrontend < Sinatra::Base
  get '/' do
    'Hello OnsFrontend!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
