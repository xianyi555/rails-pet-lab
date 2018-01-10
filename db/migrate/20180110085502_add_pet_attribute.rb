class AddPetAttribute < ActiveRecord::Migration[5.1]
  def change
  	  add_column :pets, :data_of_birth, :string
  end
end
