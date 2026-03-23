class MenuItem < ApplicationRecord
  belongs_to :restaurant

  validates :name, presence: true
  validates :price, presence: true
  validates :category, presence: true

  attribute :is_available, :boolean, default: true
end
