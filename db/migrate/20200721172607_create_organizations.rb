class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :phone_number, null: false
      t.string :email, null: false
      t.string :category, null: false
      t.text :description, null: false
      t.string :city, null: false
      t.string :zip_code, null: false
      t.string :country, null:false


      t.timestamps
    end

    create_table :admins do |t|
      t.bigint :user_id, null: false
      t.bigint :organization_id, null: false
      t.boolean :can_edit, default: false, null: false
      t.boolean :can_add_events, default: false, null: false
      t.boolean :can_add_posts, default: false, null: false
      t.boolean :can_add_admin, default: false, null: false
      t.boolean :is_owner, null: false
      t.index ["user_id", "organization_id"], name: "ix_admin_by_user_org", unique: true
      t.index ["organization_id"], name: "ix_admin_by_org"
      t.timestamps
    end

    add_foreign_key :admins, :users
    add_foreign_key :admins, :organizations
  end
end
