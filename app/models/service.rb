class Service < ApplicationRecord
  belongs_to :user
  has_many :booking

  validates :price, presence: true, numericality: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :address, presence: true, length: { maximum: 200 }
  validates :latitude, presence: true
  validates :longitude, presence: true

  # validates :photo, presence: true

  validates :restrictions, presence: true, length: { maximum: 200 }
  validates :house_description, presence: true, length: { maximum: 500 }
end
