class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :specie, inclusion: { in: %w[Dog Cat Rabbit Birds Reptiles Others] }, presence: true
  validates :price, presence: true, numericality: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :address, presence: true, length: { maximum: 200 }
  # validates :photo, presence: true
  validates :restrictions, presence: true, length: { maximum: 200 }
  validates :house_description, presence: true, length: { maximum: 500 }
end
