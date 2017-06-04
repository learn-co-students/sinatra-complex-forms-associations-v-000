class CreateOwnersTable < ActiveRecord::Migration[4.1]
  def change
    create_table :owners do |t|
      t.string :name
    end
  end
end
