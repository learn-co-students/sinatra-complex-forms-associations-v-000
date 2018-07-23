class RemoveOwnerFromPets < ActiveRecord::Migration
  def change
    remove_column :pets, :owner, :string
  end
end
