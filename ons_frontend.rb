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

  get '/series/:series/releases/:release/datasets/:dataset/slice' do
    @dataset = Dataset.find(params[:dataset], 
                params: { release_id: params[:release], 
                          series_id: params[:series] 
                })
                
    @release = Release.find( params[:release], params: { series_id: params[:series] })            
    @series = Series.find( params[:series])
     
    @dataset.dimensions.attributes.each do |id,dimension|
      if params[id] && dimension.type == "dimension"
        @dimension = dimension
        @dimension_value = dimension.values.select{|x| x.notation == params[id]}.first
      end
      if params[id] && dimension.type == "timedimension"
        @time_dimension = dimension
        #strip off "/*" from value to get the date part from the dimensions concept scheme
        date_id = params[id].split("/").first
        @time_dimension_value = dimension.values.select{|x| x.notation == date_id }.first
      end
    end
        
    @data_url = request.fullpath.gsub("/slice", "/slice-data")
    erb :"slice/index"
  end

  get '/series/:series_id/releases/:release_id/datasets/:dataset_id/slice-data' do
    @observations = Observation.find(:all, params: params )  
    data_points = []
    
    @observations.each do |obs|
      value = obs.send( obs.measures.first.slug.to_sym )
      #TODO improve date dimension so we have better values, also handle quarters
      obs_date = obs.date
      obs_date = "#{obs_date}-01-01" if obs_date.length == 4
      date = Date.parse( obs_date ).to_time.to_i
      data_points << { x: date, y: value, provisional: obs.provisional}
    end
    data_points.sort!{ |a,b| a[:x] <=> b[:x] } 
    response = [ { name: @observations.first.measures.first.slug, data: data_points } ]
    content_type :json
    response.to_json
  end    
        
  
  get '/series/:series_id/releases/:release_id/datasets/:dataset_id/observations' do
      @dataset = Dataset.find(params[:dataset_id], 
                  params: { release_id: params[:release_id], 
                            series_id: params[:series_id] 
                  })
    
    missing_dimensions = false
    @dataset.dimensions.attributes.each do |id,dimension|
      missing_dimensions = true if !params[id]
    end
                            
    if missing_dimensions
      status 400
      "Specify values for all dimensions"
    else
      @observation = Observation.find(:all, params: params).first
      if @observation
        status 303
        redirect @observation.url
      else
        status 404
        "Cannot find observation with those dimension values"
      end
    end
    
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
