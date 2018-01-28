class AlterOwnersTable < ActiveRecord::Migration
  def change
    change_table :owners do |t|
      t.integer :pet_id
    end
  end
end
