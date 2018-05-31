class CreatePetsTable < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :e
    end
  end
end