class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :description
      t.string :location
      t.date :date
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
