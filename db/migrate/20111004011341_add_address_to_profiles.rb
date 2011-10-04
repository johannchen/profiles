class AddAddressToProfiles < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.string :address, :address2, :city, :limit => 100
      t.string :state, :limit => 2
      t.string :postal_code, :limit => 10
    end
  end
end
