Feature: delete movie

  As a movie buff
  So that I can delete a movie
  I want to delete a movie

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
  
  
  Scenario: test delete movie
  Given I am on the details page for "Star Wars"
  When  I press "Delete"
  Then  I should be on the home page
  And   I should see "Movie 'Star Wars' deleted"

  
  Scenario: test create new movie
  Given I am on the home page
  When  I follow "Add new movie"
  Then  I should be on the create new movie page
  When  I fill in "Title" with "My Movie"
  And  I press "Save Changes"
  Then  I should be on the home page
  And   I should see "My Movie"
  
 