class Pet < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :owner
end