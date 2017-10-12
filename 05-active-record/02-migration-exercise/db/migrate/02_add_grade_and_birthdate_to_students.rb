class AddGradeAndBirthdateToStudents < ActiveRecord::Migration

  # run 'rake db:migrate' before executing the tests
  # add the following columns to the database
  def change
    add_column :students, :grade, :integer
    add_column :students, :birthdate, :string
  end

end
