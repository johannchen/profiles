class AddBgImageNameToThemes < ActiveRecord::Migration
  def change
    change_table :themes do |t|
      t.string :bg_image_name, :limit => 100
    end
  end
end
