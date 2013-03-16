class Place < ActiveRecord::Base
  
  # acts_as_gmappable For Google Maps                              
  
  attr_accessible :address, :description, :name, :website, :category, :image, :state, :city, :zipcode
  has_attached_file :image, styles: { large: "470x310", icon: "100x100" }, :default_url => "missing_:style.png"
  
  
  validates :name, :state, :category, presence: true
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                               size: { less_than: 5.megabytes }
  
  #For Google Maps                               
  # def gmaps4rails_address
  #     "#{address}, #{city}, #{state}, #{zipcode}"
  #   end

  geocoded_by :state
  after_validation :geocode, :if => :zipcode_changed?
  
  has_many :reviews
  
  def complete_address
    [address, city, state, zipcode].compact.join(', ')
  end
  
end

