class UpdateStatusInBookings < ActiveRecord::Migration[7.1]
  def up
    # Cambiar 'false' a 'pending'
    Booking.where(status: 'false').update_all(status: 'pending')

    # Cambiar 'true' a 'confirmed'
    Booking.where(status: 'true').update_all(status: 'confirmed')
  end

  def down
    # Revertir los cambios en caso de rollback
    Booking.where(status: 'pending').update_all(status: 'false')
    Booking.where(status: 'confirmed').update_all(status: 'true')
  end
end
