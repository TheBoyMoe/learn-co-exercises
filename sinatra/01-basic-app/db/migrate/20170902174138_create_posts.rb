# create a migration using a rake task
# 'rake db:create_migration NAME=create_posts'

# 1. setup dbase connection in environment.rb
# 2. create Migration
# 3. run 'db:migrate' to create table
# 4. create your model class (inherits from ActiveRecord::Base)
class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
