Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  movies = Array.new
  page.all("table#movies tbody/tr").each do |row|
      movies += row.all("td[1]").collect.each { |element| element.text  }
  end

  assert(movies.index(e1) < movies.index(e2), "#{e1} should occur before #{e2}")
end

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

Then /^I should see all of the movies:$/ do |table|
     assert_equal(table.hashes.length, page.all("table#movies tbody/tr").count, "Movie count is not what it should be")
end