class IncreaseFbTokenLength < ActiveRecord::Migration
  def up
    change_column :users, :fb_token, :string, :limit => 255
  end

  def down
    change_column :users, :fb_token, :string, :limit => 100
  end
end
