class Observation < ActiveResource::Base
  self.site = data_api_url
  self.prefix = '/series/slug/releases/slug/datasets/slug/'
end