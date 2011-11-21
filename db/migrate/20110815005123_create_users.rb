class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider, :uid, :limit => 50
      t.timestamps
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.token_authenticatable
      t.string :workflow_state, :limit => 255, :default => 'pending_review'
      t.integer :roles
      t.string :timezone, :limit => 50
      t.string :fb_token, :limit => 100
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true

    add_index :users, :authentication_token, :unique => true
  end
end
