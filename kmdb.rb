# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!
# - Note rubric explanation for appropriate use of external resources.

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)
# - You are welcome to use external resources for help with the assignment (including
#   colleagues, AI, internet search, etc). However, the solution you submit must
#   utilize the skills and strategies covered in class. Alternate solutions which
#   do not demonstrate an understanding of the approaches used in class will receive
#   significant deductions. Any concern should be raised with faculty prior to the due date.

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
Studio.destroy_all
Movie.destroy_all
Actor.destroy_all
Role.destroy_all
Rails.logger.info "------------------------"
Rails.logger.info "----- FRESH START! -----"
Rails.logger.info "------------------------"

# Generate models and tables, according to the domain model.
# TODO!

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.

new_studio = Studio.new
new_studio["name"] = "Warner Bros."
new_studio.save

new_movie = Movie.new
new_movie["title"] = "Batman Begins"
new_movie["year_released"] = 2005
new_movie["rated"] = "PG-13"
new_movie["studio_id"] = Studio.find_by({"name" => "Warner Bros."}).id
new_movie.save

new_movie = Movie.new
new_movie["title"] = "The Dark Knight"
new_movie["year_released"] = 2008
new_movie["rated"] = "PG-13"
new_movie["studio_id"] = Studio.find_by({"name" => "Warner Bros."}).id
new_movie.save

new_movie = Movie.new
new_movie["title"] = "The Dark Knight Rises"
new_movie["year_released"] = 2012
new_movie["rated"] = "PG-13"
new_movie["studio_id"] = Studio.find_by({"name" => "Warner Bros."}).id
new_movie.save

actors = ["Christian Bale", "Michael Caine", "Liam Neeson", "Katie Holmes", "Gary Oldman", "Heath Ledger", "Aaron Eckhart", "Maggie Gyllenhaal", "Tom Hardy", "Joseph Gordon-Levitt", "Anne Hathaway" ]
for actor in actors do
    new_actor = Actor.new
    new_actor["name"] = actor
    new_actor.save
end

roles = [
  { movie: "Batman Begins", actor: "Christian Bale", role: "Bruce Wayne" },
  { movie: "Batman Begins", actor: "Michael Caine", role: "Alfred" },
  { movie: "Batman Begins", actor: "Liam Neeson", role: "Ra's Al Ghul" },
  { movie: "Batman Begins", actor: "Katie Holmes", role: "Rachel Dawes" },
  { movie: "Batman Begins", actor: "Gary Oldman", role: "Commissioner Gordon" },
  { movie: "The Dark Knight", actor: "Christian Bale", role: "Bruce Wayne" },
  { movie: "The Dark Knight", actor: "Heath Ledger", role: "Joker" },
  { movie: "The Dark Knight", actor: "Aaron Eckhart", role: "Harvey Dent" },
  { movie: "The Dark Knight", actor: "Michael Caine", role: "Alfred" },
  { movie: "The Dark Knight", actor: "Maggie Gyllenhaal", role: "Rachel Dawes" },
  { movie: "The Dark Knight Rises", actor: "Christian Bale", role: "Bruce Wayne" },
  { movie: "The Dark Knight Rises", actor: "Gary Oldman", role: "Commissioner Gordon" },
  { movie: "The Dark Knight Rises", actor: "Tom Hardy", role: "Bane" },
  { movie: "The Dark Knight Rises", actor: "Joseph Gordon-Levitt", role: "John Blake" },
  { movie: "The Dark Knight Rises", actor: "Anne Hathaway", role: "Selina Kyle" }
]

for rol in roles do
    new_role = Role.new
    new_role["character_name"] = rol[:role]
    new_role["actor_id"] = Actor.find_by({"name" => rol[:actor]}).id
    new_role["movie_id"] = Movie.find_by({"title" => rol[:movie]}).id
    new_role.save
end

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.

for mov in Movie.all do
    puts mov.title.ljust(25) + mov.year_released.to_s.ljust(10) + mov.rated.ljust(10) + Studio.find_by({"id" => mov.studio_id}).name
end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""


# Query the cast data and loop through the results to display the cast output for each movie.
for cast in Role.all do
    puts Movie.find_by({"id" => cast.movie_id}).title.ljust(25) + Actor.find_by({"id" => cast.actor_id}).name.ljust(25) + cast.character_name
end
