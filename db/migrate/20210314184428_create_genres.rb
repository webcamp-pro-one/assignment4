class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :name
      t.timestamp :create_at, default: Time.now
      t.timestamp :update_at, default: Time.now

      t.timestamps
    end
  end
end
