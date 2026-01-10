class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :profile_name, null: false
      t.text :introduction
      t.integer :cat_count, default: 0

      t.timestamps
    end
  end
end
