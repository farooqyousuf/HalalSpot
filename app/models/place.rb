class Place < ActiveRecord::Base
  
  # acts_as_gmappable For Google Maps                              
  
  attr_accessible :address, :description, :name, :website, :category, :image, :state, :city, :zipcode
  has_attached_file :image, styles: { medium: "150x150" }, #:default_url => 'assets/images/default_small_avatar.png'
  
  
  validates :name, :address, :state, :city, :zipcode, :category, presence: true
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                               size: { less_than: 5.megabytes }
  
  #For Google Maps                               
  # def gmaps4rails_address
  #     "#{address}, #{city}, #{state}, #{zipcode}"
  #   end

  geocoded_by :complete_address
  after_validation :geocode, :if => :address_changed?
  
  def complete_address
    [address, city, state, zipcode].compact.join(', ')
  end
  
end

