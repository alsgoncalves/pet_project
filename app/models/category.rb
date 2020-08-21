class Category < ApplicationRecord
  has_many :organizations

  validates :name, presence: :true
  validates :icon, presence: :true
end
