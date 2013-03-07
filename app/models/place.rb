class Place < ActiveRecord::Base
  attr_accessible :address, :description, :name, :website
  
  validates :name, :address, presence: true
end

