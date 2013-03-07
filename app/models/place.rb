class Place < ActiveRecord::Base
  attr_accessible :address, :description, :name, :website, :category
  
  validates :name, :address, presence: true
end

