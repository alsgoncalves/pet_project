class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :admins
  has_many :participations
  has_many :favourites

  def find_admin_for(organization_id)
    admins.find { |admin| admin.organization_id == organization_id }
  end

  def admin_for?(organization_id)
    admin = find_admin_for(organization_id)
    !admin.nil?
  end

  def can_edit?(organization)
    admin = find_admin_for(organization.id)
    !admin.nil? && (admin.can_edit || admin.is_owner)
  end

  def can_add_events_for?(organization)
    admin = find_admin_for(organization.id)
    !admin.nil? && (admin.can_add_events || admin.is_owner)
  end

  def can_add_posts_for?(organization)
    admin = find_admin_for(organization.id)
    !admin.nil? && (admin.can_add_posts || admin.is_owner)
  end

  def can_add_admin_to?(organization)
    admin = find_admin_for(organization.id)
    !admin.nil? && (admin.can_add_admin || admin.is_owner)
  end

  def is_owner?(organization)
    admin = find_admin_for(organization.id)
    !admin.nil? && admin.is_owner
  end
end
