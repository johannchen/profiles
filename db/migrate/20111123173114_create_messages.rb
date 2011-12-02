class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :profile_id
      t.integer :from_id
      t.string :method, :limit => 50

      t.timestamps
    end
  end
end
