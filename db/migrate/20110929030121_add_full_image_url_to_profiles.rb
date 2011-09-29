class AddFullImageUrlToProfiles < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.rename :image_url, :small_image_url
      t.string :full_image_url, :limit => 255
    end
  end
end
