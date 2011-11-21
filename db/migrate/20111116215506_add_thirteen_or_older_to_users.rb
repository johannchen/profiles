class AddThirteenOrOlderToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :thirteen_or_older
    end
  end
end
