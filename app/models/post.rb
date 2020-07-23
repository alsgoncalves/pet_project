class Post < ApplicationRecord
  belongs_to :organization #through: :admins

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 20 }
end
