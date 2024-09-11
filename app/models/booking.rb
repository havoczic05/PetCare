class Booking < ApplicationRecord
  belongs_to :pet
  belongs_to :service

  validates :start_date, :end_date, presence: true
end
