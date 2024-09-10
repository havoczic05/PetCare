class RenameTypeToSpeciesInPets < ActiveRecord::Migration[7.1]
  def change
    rename_column :pets, :type, :specie
  end
end
