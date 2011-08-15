class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name, :limit => 255
      t.string :headline, :limit => 50
      t.string :gender, :limit => 1
      t.date :birthday
      t.string :phone, :limit => 50
      t.string :location, :limit => 50
      t.string :image_url, :limit => 255
      t.string :facebook_id, :facebook_url, :limit => 255
      t.string :twitter_id, :twitter_url, :limit => 255
      t.string :workflow_state, :limit => 255
      t.timestamps
    end
  end
end
