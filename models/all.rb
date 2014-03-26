require 'active_resource'

def data_api_url
  ENV['DATA_API_URL'] || 'https://data-api.com'
end

ActiveSupport::Dependencies.autoload_paths << File.dirname(__FILE__)
