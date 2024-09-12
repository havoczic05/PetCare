class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :name, presence: true, length: { in: 2..20 }
  validates :specie, inclusion: { in: %w[Dog Cat Rodent Bird Reptile Others] }, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :age, presence: true, length: { maximum: 3 }, numericality: { only_integer: true }
  validates :age, presence: true, length: { maximum: 3 }, numericality: { only_integer: true }
  validates :weight, presence: true, length: { maximum: 5 }, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 30.9, message: 'debe ser un número válido' }
end
