class Place < ActiveRecord::Base
  
  # acts_as_gmappable For Google Maps                              
  
  attr_accessible :address, :description, :name, :website, :category, :image, :state, :city, :zipcode
  has_attached_file :image, styles: { medium: "200x200" }
  
  validates :name, :address, :state, :city, :zipcode, :category, presence: true
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                               size: { less_than: 5.megabytes }
  
  #For Google Maps                               
  # def gmaps4rails_address
  #     "#{address}, #{city}, #{state}, #{zipcode}"
  #   end
  
end

