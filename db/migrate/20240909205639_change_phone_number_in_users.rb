class ChangePhoneNumberInUsers < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :phone_number, :string
  end

  def down
    change_column :users, :phone_number, :integer
  end
end
