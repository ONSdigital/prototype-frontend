class Dataset < ActiveResource::Base
  self.site = data_api_url
  self.prefix = '/series/:series_id/releases/:release_id/'

  has_many :observations
  belongs_to :release

end
