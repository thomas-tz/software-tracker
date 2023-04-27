class Category < ApplicationRecord
  include PgSearch::Model
  multisearchable against: :name

  has_many :tools, dependent: :nullify

  validates :name, presence: true
end
