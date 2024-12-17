class Pokemon < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_many :rentings, dependent: :destroy
  has_one_attached :photo

  enum sexe: { Female: 0, Male: 1}

  validates :name, presence: true
  validates :price_per_day, presence: true
  validates :sexe, presence: true


  pg_search_scope :search_by_name_and_main_type_and_main_power,
    against: [:name, :main_type, :main_power],
    using: {
      tsearch: { prefix: true }
}

end
