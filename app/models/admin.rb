class Admin < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  validates :can_edit,                presence: true
  validates :can_add_events,          presence: true
  validates :can_add_posts,           presence: true
  validates :can_add_admin,           presence: true
  validates :is_owner,                presence: true

end
