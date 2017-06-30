class AddDobToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :date_of_birth, :date
  end
end
