class Owner < ActiveRecord::Base
  has_many :pets
end
# Because an owner instance has many pet instances (we use AR has_many macro above) and
# because the "pet_ids" key of the owner hash (nested inside params hash)
# points to an array of @id attribute values of pet instances belonging to an owner instance
# we can call #pets on an owner instance and
# the array of pet instances belonging to that owner instance is returned
