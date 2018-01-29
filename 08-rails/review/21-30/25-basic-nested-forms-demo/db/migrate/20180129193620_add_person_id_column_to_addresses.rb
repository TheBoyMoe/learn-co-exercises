class AddPersonIdColumnToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :person_id, :integer
  end
end
