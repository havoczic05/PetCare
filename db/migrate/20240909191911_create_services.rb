class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.integer :price
      t.string :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :restrictions
      t.string :house_description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
