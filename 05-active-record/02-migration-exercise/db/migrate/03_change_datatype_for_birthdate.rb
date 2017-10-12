class ChangeDatatypeForBirthdate < ActiveRecord::Migration

  # run 'rake db:migrate' prior to running tests
  # change column datatype
  def change
    change_column :students, :birthdate, :datetime
  end

end
