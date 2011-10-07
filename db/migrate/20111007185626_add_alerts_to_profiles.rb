class AddAlertsToProfiles < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.integer :alerts
    end
  end
end
