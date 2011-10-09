class AddBioToProfiles < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.text :bio
    end
  end
end
