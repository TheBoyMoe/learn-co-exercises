class Movie < ActiveRecord::Base
  # steps
  # 1. create migrate folder and 01_create_movies.rb file
  # 2. add #change method to create the table whereyou define the column names - automatically mapped to atribute names
  # 3. run 'rake db:migrate' from the project root to create the database - if all goes well you'll see a 'create_table...' message
  # 4. run 'rake db:migrate SINATRA_ENV=test' from the command prompt
  # 5. execute the tests

end
