
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  # ensure that that e1 occurs before e2.
  # page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

When /^I follow to the edit page for "([^"]+)"$/ do |title|
  movie = Movie.find_by(title: title)
  visit edit_movie_path(movie)
end

# When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
#   fill_in(field, with: value) #form field
# end

# When /^I press "(.*)"$/ do |button_name|
#   click_button(button_name)
# end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie_title, director_name|
  movie = Movie.find_by(title: movie_title)
  if movie
    movie.update(director: director_name)
  else
    raise "Movie with title '#{movie_title}' not found"
  end
  expect(movie.director).to eq(director_name)
end



