require 'sinatra/base'

class OnsFrontend < Sinatra::Base
  get '/' do
    'Hello OnsFrontend!'
  end

  get '/series/release/dataset/:observation' do
    erb :observation
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
