desc "Import data"
task :import_data => :environment do
  
    require 'nokogiri'
    require 'open-uri'

    masjids_url_array = ["http://www.salatomatic.com/c/Fairfax-amp-Loudoun+264/?t=m",
      "http://www.salatomatic.com/c/Arlington-amp-Alexandria+7",
      "http://www.salatomatic.com/c/Norfolk+116",
      "http://www.salatomatic.com/c/Richmond+141",
      "http://www.salatomatic.com/c/Western-Virginia+136",
      "http://www.salatomatic.com/c/Woodbridge+95"]
      
    schools_url_array = ["http://www.salatomatic.com/c/Arlington-amp-Alexandria+7/?t=s",
      "http://www.salatomatic.com/c/Richmond+141/?t=s",
      "http://www.salatomatic.com/c/Woodbridge+95/?t=s"]
    
    restaurants_url_array = ["http://www.zabihah.com/c/Arlington-amp-Alexandria+7/?t=r",
      "http://www.zabihah.com/c/Fairfax-amp-Loudoun+264/?t=r",
      "http://www.zabihah.com/c/Richmond+141/?t=r",
      "http://www.zabihah.com/c/Western-Virginia+136",
      "http://www.zabihah.com/c/Woodbridge+95"]
    
    businesses_url_array = ["http://www.zabihah.com/c/Arlington-amp-Alexandria+7/?t=g",
      "http://www.zabihah.com/c/Arlington-amp-Alexandria+7/?t=b",
      "http://www.zabihah.com/c/Fairfax-amp-Loudoun+264/?t=g",
      "http://www.zabihah.com/c/Richmond+141/?t=g",
      "http://www.zabihah.com/c/Western-Virginia+136/?t=g",
      "http://www.zabihah.com/c/Woodbridge+95/?t=g"]
      
    #VA Masjids
    masjids_url_array.each do |url|
      doc = Nokogiri::HTML(open(url))
      doc.css(".subtitleLink b").each do |item|
        Place.create!(:name => item.text.strip, 
                      :state => "VA",
                      :category => "Masjid",
                      :description => "This is a masjid, please enter a better description if you know one.")    
      end
    end
    
    #VA Schools
    schools_url_array.each do |url|
      doc = Nokogiri::HTML(open(url))
      doc.css(".subtitleLink b").each do |item|
        Place.create!(:name => item.text.strip, 
                      :state => "VA",
                      :category => "Islamic School",
                      :description => "This is a school, please enter a better description if you know one.")    
      end
    end
    
    #VA Restaurants
    restaurants_url_array.each do |url|
      doc = Nokogiri::HTML(open(url))
      doc.css(".subtitleLink b").each do |item|
        Place.create!(:name => item.text.strip, 
                      :state => "VA",
                      :category => "Restaurant",
                      :description => "This is a restaurant, please enter a better description if you know one.")    
      end
    end
    
    #VA Businesses
    businesses_url_array.each do |url|
      doc = Nokogiri::HTML(open(url))
      doc.css(".subtitleLink b").each do |item|
        Place.create!(:name => item.text.strip, 
                      :state => "VA",
                      :category => "Business",
                      :description => "This is a business, please enter a better description if you know one.")    
      end
    end
    
    
    
     
  end