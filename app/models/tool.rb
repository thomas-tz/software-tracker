class Tool < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :users

  validates :name, presence: true
  validates :category_id, presence: true
end
