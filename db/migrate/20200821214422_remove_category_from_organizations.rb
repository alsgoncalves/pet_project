class RemoveCategoryFromOrganizations < ActiveRecord::Migration[6.0]
  def change
    remove_column :organizations, :category
  end
end
