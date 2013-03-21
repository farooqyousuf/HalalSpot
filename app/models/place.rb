class Place < ActiveRecord::Base
  
  # acts_as_gmappable For Google Maps                              
  
  attr_accessible :address, :description, :name, :website, :category, :image, :state, :city, :zipcode, :phone
  has_attached_file :image, styles: { large: "470x310", icon: "100x100" }, :default_url => "missing_:style.png"
  
  
  validates :name, :address, :city, :state, :zipcode, :category, presence: true
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                               size: { less_than: 5.megabytes }
                               
  # validates_uniqueness_of :name
  
  #For Google Maps                               
  # def gmaps4rails_address
  #     "#{address}, #{city}, #{state}, #{zipcode}"
  #   end

  geocoded_by :complete_address
  after_validation :geocode, :if => :check_address_changed?
  
  has_many :reviews
  
  def complete_address
    [address, city, state, zipcode].compact.join(', ')
  end
  
  def check_address_changed?
    attrs = %w(address city state zipcode)
    attrs.any?{|a| send "#{a}_changed?"}
  end
  
end

