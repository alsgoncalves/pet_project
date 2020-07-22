class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :description
      t.integer :part_count
      t.datetime :date
      t.string :location

      t.timestamps
    end
  end
end
