class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :booking

  validates :content, presence: true, length: { minimum: 1 }

  after_create_commit -> {
    broadcast_append_to "booking_#{booking_id}",
    target: "messages_#{booking_id}"
  }
end
