class Observation < ActiveResource::Base
  self.site = data_api_url
  self.prefix = '/series/:series_id/releases/:release_id/datasets/:dataset_id/'

  belongs_to :dataset

end
