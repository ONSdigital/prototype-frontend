Feature: Observation page
  In order view a single observation
  As an expert data user
  I want to view a page with all the details for a single observation on it
  
  Scenario: get observation page
    When I go to the path "/series/release/dataset/a-observation-3"
    Then I should see "111.5"
    And I should see "Date"
    And I should see "December 2013"
    And I should see "Product"
    And I should see "Alcoholic Beverages - SPECIAL INDEX FOR USE IN NSO - Manu incl duty"