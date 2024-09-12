class AddSpecieToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :specie, :string
  end
end
