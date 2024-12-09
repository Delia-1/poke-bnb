class Pokemon < ApplicationRecord
  belongs_to :user
  has_many :rentings
  has_one_attached :photo

  enum sexe: { Female: 0, Male: 1}

  validates :name, presence: true
  validates :price_per_day, presence: true
  validates :sexe, presence: true

end
