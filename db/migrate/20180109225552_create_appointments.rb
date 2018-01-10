class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.string :veterinarian
      t.string :text
      t.string :time
      t.string :string
      t.string :reason
      t.string :string
      t.string :pet_id
      t.string :integer

      t.timestamps
    end
  end
end
