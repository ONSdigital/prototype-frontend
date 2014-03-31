require 'sinatra/base'
require 'sinatra/content_for'
require 'sinatra/partial'
require_relative 'models/all'

class OnsFrontend < Sinatra::Base
  helpers Sinatra::ContentFor
  register ::Sinatra::Partial
  
  set :partial_template_engine, :erb
  enable :partial_underscores
  
  get '/' do
    'Hello OnsFrontend!'
  end

  get '/series/:series/releases/:release/datasets/:dataset/observations/:observation' do
    @observation = Observation.find(params[:observation],
                                    params: { series_id: params[:series],
                                              release_id: params[:release],
                                              dataset_id: params[:dataset]}
                                   )
    @dataset = @observation.dataset
    @release = @observation.dataset.release
    @series = @observation.dataset.release.series
    erb :observation
  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end
