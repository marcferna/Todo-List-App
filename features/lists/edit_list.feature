Feature: Edit List
  In order to modify a created list
  A user
  Should be able edit lists

    Background:
      Given I am logged in
      And I have a list

    Scenario: User edits list with valid data
      When I edit list with valid data
      Then I should see a successful updated list message
