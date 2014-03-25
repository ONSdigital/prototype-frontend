require 'sinatra/base'
require_relative 'models/all'

class OnsFrontend < Sinatra::Base
  get '/' do
    'Hello OnsFrontend!'
  end

  get '/series/:series/releases/:release/datasets/:dataset/observations/:observation' do
    @observation = Observation.find(params[:observation])
      puts @observation.dimensions.date.value.inspect
    erb :observation
  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end
