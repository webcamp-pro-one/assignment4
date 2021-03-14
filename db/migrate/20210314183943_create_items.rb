class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image_id
      t.text :introduction
      t.integer :price
      t.integer :is_active, default: 0
      t.timestamp :create_at, default: Time.now
      t.timestamp :update_at, default: Time.now
      t.integer :genre_id

      t.timestamps
    end
  end
end
