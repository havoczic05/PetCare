class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :specie
      t.string :description
      t.string :likes
      t.string :dislikes
      t.integer :age
      t.float :weight
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
