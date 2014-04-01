require 'sinatra/base'
require 'sinatra/content_for'
require 'sinatra/partial'
require 'bigdecimal'
require_relative 'models/all'

class OnsFrontend < Sinatra::Base
  helpers Sinatra::ContentFor
  register ::Sinatra::Partial
  
  set :partial_template_engine, :erb
  enable :partial_underscores
  
  get '/' do
    erb :index
  end

  get '/series/:series/releases/:release/datasets/:dataset/observations/:observation' do
    @observation = Observation.find(params[:observation],
                                    params: { series_id: params[:series],
                                              release_id: params[:release],
                                              dataset_id: params[:dataset]}
                                   )


                                   
    @related = find_related_observations( @observation )         
            
    @dataset = Dataset.find(params[:dataset], 
                params: { release_id: params[:release], 
                          series_id: params[:series] 
                })
                
    @release = Release.find( params[:release], params: { series_id: params[:series] })            
    @series = Series.find( params[:series])
    @measure = @observation.measures.first.slug
    erb :"observation/index"
  end
  
  def find_related_observations( observation )
    related = {
      next: { month: nil, year: nil },
      previous: { month: nil, year: nil }
    }
    
    #find previous/next month/year if we have them                                   
    if observation.dimensions.date
      value = observation.dimensions.date.value
      [:previous, :next].each do |axis|
        concepts = value.attributes[axis]
        concepts.each do |concept|
          related_obs = Observation.find(:all, params: { series_id: params[:series],
                                                         release_id: params[:release],
                                                         dataset_id: params[:dataset], 
                                                         product: observation.product,
                                                         date: concept.value } )
          related[ axis ][concept.period.to_sym] = related_obs.first
        end
      end  
    end   
    related
  end
  
  # start the server if ruby file executed directly
  run! if app_file == $0
end
