class Admin < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  def find_admin(user)
    current_user_admin = admins.find{|admin|
      admin.user_id == user.id
    }
    return current_user_admin
  end
end
