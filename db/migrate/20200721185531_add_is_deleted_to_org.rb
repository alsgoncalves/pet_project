class AddIsDeletedToOrg < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :is_deleted, :boolean, default: false, null: false
  end
end
