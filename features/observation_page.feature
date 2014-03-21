Feature: Observation page
  In order view a single observation
  As an expert data user
  I want to view a page with all the details for a single observation on it
  
  Scenario: get observation page
    Given the fixture "a-observation-3.json" is available at the URL "https://data-api.com/series/slug/releases/slug/datasets/slug/observations/a-observation-3.json"
    When I go to the path "/series/release/dataset/a-observation-3"
    Then I should see "60.5"
    And I should see "An Date"
    And I should see "June 1974"
    And I should see "Product"
    And I should see "Alcoholic Beverages - SPECIAL INDEX FOR USE IN NSO - Manu excl duty"
    And I should see "In June 1974, the price index for Alcoholic Beverages - SPECIAL INDEX FOR USE IN NSO - Manu excl duty was..." within "p.lead"