class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings, dependent: :destroy
  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :specie, inclusion: { in: %w[Dog Cat Rodent Bird Reptile Others] }, presence: true
  validates :price, presence: true, numericality: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :address, presence: true, length: { maximum: 200 }
  validates :photo, presence: true
  validates :restrictions, presence: true, length: { maximum: 200 }
  validates :house_description, presence: true, length: { maximum: 500 }

  def recent_reviews(limit = 3)
    reviews.order(created_at: :desc).limit(limit)
  end
end
