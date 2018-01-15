class Pet < ActiveRecord::Base
  belongs_to :owner

  def owner_name
    self.owner.name
  end

  def owner_name=(o_name)
    # Alternate way
    # self.owner = Owner.new(name: o_name)
    self.build_owner(name: o_name) unless o_name.blank?
  end
end