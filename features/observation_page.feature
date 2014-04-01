Feature: Observation page
  In order view a single observation
  As an expert data user
  I want to view a page with all the details for a single observation on it

  Scenario: get observation page
    Given the fixture "mca5-2013may.json" is available at the URL "https://data-api.com/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds/observations/mca5-2013may.json"
    And the fixture "ppi-csdb-ds.json" is available at the URL "https://data-api.com/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds.json"
    And the fixture "2014-02-18.json" is available at the URL "https://data-api.com/series/producer-price-index/releases/2014-02-18.json"
    And the fixture "producer-price-index.json" is available at the URL "https://data-api.com/series/producer-price-index.json"
    And the fixture "empty.json" is available at the URL "https://data-api.com/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds/observations.json?date=2013APR&product=MCA5"
    And the fixture "empty.json" is available at the URL "https://data-api.com/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds/observations.json?date=2013JUN&product=MCA5"
    And the fixture "empty.json" is available at the URL "https://data-api.com/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds/observations.json?date=2012MAY&product=MCA5"
    And the fixture "empty.json" is available at the URL "https://data-api.com/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds/observations.json?date=2014MAY&product=MCA5"

    When I go to the path "/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds/observations/mca5-2013may"
    Then I should see "106.2" within "div.observation p.main"
    And I should see "date" within "table"
    And I should see "2013 MAY" within "table"
    And I should see "product" within "table"
    And I should see "Input component - Imported products used in the Manufacture of" within "table"
    And I should see "In 2013 MAY, the price_index for Input component - Imported products used in the Manufacture of was..." within "p.lead"
