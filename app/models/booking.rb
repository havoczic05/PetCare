class Booking < ApplicationRecord
  has_many :activities
  belongs_to :pet
  belongs_to :service

  validates :start_date, :end_date, presence: true
end
