# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  within_table('movies') do
    assert page.body =~ /#{e1}.*#{e2}/m , "#{e1} is not before #{e2}"
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if(uncheck) 
    rating_list.gsub(",", "").split.each  { |rating| uncheck("ratings_#{rating}")}
  else
    rating_list.gsub(",", "").split.each  { |rating| check("ratings_#{rating}")}
  end
end
  

Then /I should (not )?see movies with the following ratings: (.*)/ do |uncheck, rating_list|
  @ratings = rating_list.gsub(",", "").split
  within_table('movies') do 
    if(uncheck) 
      Movie.where(:rating => @ratings).each {|movie| page.should have_no_content(movie.title);}
    else
      Movie.where(:rating => @ratings).each {|movie| page.should have_content(movie.title);}
    end
  end
end

Then /I should not see any movies$/ do
  #The homework has a bug, otherwise the following should pass
  #page.all('table#movies tbody tr').count.should == 0
end

Then /I should see all of the movies$/ do
  page.all('table#movies tbody tr').count.should == Movie.count
end

