class AddActiveToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :active, :boolean
  end
end
