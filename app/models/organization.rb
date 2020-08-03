class Organization < ApplicationRecord
  # Schema relationships
  has_many :admins
  has_many :events
  has_many :favourites
  has_many :posts, dependent: :destroy

  has_many_attached :photos

  # Model validations
  validates :name,          presence: true, length: { minimum: 2 }
  validates :address,       presence: true, length: { minimum: 2 }
  validates :phone_number,  presence: true, length: { minimum: 9 }
  validates :email,         presence: true, length: { minimum: 2 } # Missing the Regex validation
  validates :category,      presence: true, length: { minimum: 2 } # Provide a list to choose from
  validates :description,   presence: true, length: { minimum: 5 }

  # Get the Organization's coordinates based on the address the user provides
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Get the city, zip_code and country based on the coordinates
  reverse_geocoded_by :latitude, :longitude do |organization, results|
    if geo = results.first
      organization.city     = geo.city
      organization.zip_code = geo.postal_code
      organization.country  = geo.country
    end
  end
  after_validation :reverse_geocode

  # Gets the user that is the Organization's admin
  # There's a single admin per Organization
  def find_admin(user)
    current_user_admin = admins.find { |admin| admin.user_id == user.id }
    return current_user_admin
  end
end
