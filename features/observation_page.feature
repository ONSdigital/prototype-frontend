Feature: Observation page
  In order view a single observation
  As an expert data user
  I want to view a page with all the details for a single observation on it

  Scenario: get observation page
    Given the fixture "mca5-2013may.json" is available at the URL "https://data-api.com/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds/observations/mca5-2013may.json"
    When I go to the path "/series/producer-price-index/releases/2014-02-18/datasets/ppi-csdb-ds/observations/mca5-2013may"
    Then I should see "106.2" within "div.observation p.main"
    And I should see "date" within "table"
    And I should see "2013 MAY" within "table"
    And I should see "product" within "table"
    And I should see "Input component - Imported products used in the Manufacture of" within "table"
    And I should see "In 2013 MAY, the price index for Input component - Imported products used in the Manufacture of was..." within "p.lead"
