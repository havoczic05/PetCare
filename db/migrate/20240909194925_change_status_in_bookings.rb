class ChangeStatusInBookings < ActiveRecord::Migration[7.1]
  def up
    change_column_default :bookings, :status, nil
    execute "ALTER TABLE bookings ALTER COLUMN status TYPE boolean USING (status::boolean)"
    change_column_default :bookings, :status, false 
  end

  def down
    change_column :bookings, :status, :string
  end
end
