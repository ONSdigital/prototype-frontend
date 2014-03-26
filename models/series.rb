class Series < ActiveResource::Base
  self.site = data_api_url

  has_many :releases

end
