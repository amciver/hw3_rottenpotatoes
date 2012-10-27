# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.gsub!(/[']/, '')
  rating_list.split(',').each do |rating|
    if uncheck == "un"
      step "I uncheck \"ratings_#{rating.strip}\""
    else
      step "I check \"ratings_#{rating.strip}\""
    end
  end
end

#Then /I should see all of the movies/ do |movies_table|
#  movies_table.hashes do |movie|
#    p movie.inspect
#  end
#end
Then /^I should see all of the movies:$/ do |table|
  # table is a | The Terminator          | R      | 26-Oct-1984  |pending
     assert_equal(table.hashes.length, page.all("table#movies tbody/tr").count)
end