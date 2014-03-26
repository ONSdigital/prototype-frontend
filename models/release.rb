class Release < ActiveResource::Base
  self.site = data_api_url
  self.prefix = '/series/:series_id/'

  has_many :datasets
  belongs_to :series

end
