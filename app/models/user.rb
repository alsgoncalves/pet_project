class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :admins
  has_many :participations
  has_many :favourites

  def find_admin_for(organization_id)
    admins.first { |admin| admin.organization_id == organization_id }
  end

  def admin_for?(organization_id)
    admin = find_admin_for(organization_id)
    !admin.nil?
  end

  def admin_can_edit?(organization_id)
    admin = find_admin_for(organization_id)
    !admin.nil? && admin.can_edit
  end

  def admin_can_add_events?(organization_id)
    admin = find_admin_for(organization_id)
    !admin.nil? && admin.can_add_events
  end

  def admin_can_add_posts?(organization_id)
    admin = find_admin_for(organization_id)
    !admin.nil? && admin.can_add_posts
  end

  def admin_can_add_admin?(organization_id)
    admin = find_admin_for(organization_id)
    !admin.nil? && admin.can_add_admin
  end

end