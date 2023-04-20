class Category < ApplicationRecord
  has_many :tools, dependent: :nullify

  validates :name, presence: true
end
