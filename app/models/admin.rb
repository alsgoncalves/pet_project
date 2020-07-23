class Admin < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  validates :can_edit,                presence: true
  validates :can_add_events,          presence: true
  validates :can_add_posts,           presence: true
  validates :can_add_admin,           presence: true
  validates :is_owner,                presence: true

  def find_admin(user)
    current_user_admin = admins.find{|admin|
      admin.user_id == user.id
    }
    return current_user_admin
  end

end
