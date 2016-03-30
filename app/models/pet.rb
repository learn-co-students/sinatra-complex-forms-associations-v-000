
class Pet < ActiveRecord::Base
  belongs_to :owner

  def owner_ids=(ids)
    self.owner = Owner.find(ids[-1])
  end

end