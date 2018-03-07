class CreatePetsTable < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.belongs_to :owner, index: true
      t.integer :owner_id
    end
  end
end
