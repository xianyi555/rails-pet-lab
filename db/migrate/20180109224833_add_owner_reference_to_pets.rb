class AddOwnerReferenceToPets < ActiveRecord::Migration[5.1]
  def change
    add_reference :pets, :owner, foreign_key: true
  end
end
