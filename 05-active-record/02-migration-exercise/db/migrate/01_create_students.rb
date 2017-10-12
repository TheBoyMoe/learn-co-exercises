class CreateStudents < ActiveRecord::Migration

  # run 'rake db:migrate' before executing the tests
  # create the students table
  def change
    create_table :students do |c|
      c.string :name
    end
  end

end
