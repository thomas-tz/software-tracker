class Category < ApplicationRecord
  has_many :tools

  accepts_nested_attributes_for :tools
end
