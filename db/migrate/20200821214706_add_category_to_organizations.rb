class AddCategoryToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_reference :organizations, :category, null: false, foreign_key: true
  end
end
