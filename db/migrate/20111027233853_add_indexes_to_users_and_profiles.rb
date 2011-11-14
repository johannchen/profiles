class AddIndexesToUsersAndProfiles < ActiveRecord::Migration
  def change
    add_index :users,      [:provider, :uid], :unique => true
    add_index :users,       :roles
    add_index :themes,      :profile_id
    add_index :profiles,    :user_id,         :unique => true
    add_index :profiles,    :workflow_state
    add_index :friendships, :profile_id
  end
end
