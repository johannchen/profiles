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
      t.boolean :validated, :default => false
      t.string :timezone, :limit => 50
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true

    add_index :users, :authentication_token, :unique => true
  end
end
