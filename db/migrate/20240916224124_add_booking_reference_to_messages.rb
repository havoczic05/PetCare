class AddBookingReferenceToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :booking, foreign_key: true
  end
end
