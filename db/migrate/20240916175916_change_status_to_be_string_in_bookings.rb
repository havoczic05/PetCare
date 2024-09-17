class ChangeStatusToBeStringInBookings < ActiveRecord::Migration[7.1]
  def up
    change_column :bookings, :status, :string
    change_column_default :bookings, :status, "pending"

    Booking.where(status: true).update_all(status: 'confirmed')
    Booking.where(status: false).update_all(status: 'pending')
  end

  def down
    Booking.where(status: 'confirmed').update_all(status: true)
    Booking.where(status: 'pending').update_all(status: false)

    # Luego se cambia el tipo de la columna de nuevo a booleano
    change_column :bookings, :status, :boolean
  end
end
