desc "Import data"
task :import_data => :environment do
  
    require 'nokogiri'
    require 'open-uri'

    url_array = ["http://www.salatomatic.com/c/Fairfax-amp-Loudoun+264/?t=m",
      "http://www.salatomatic.com/c/Arlington-amp-Alexandria+7"]
      
    url_array.each do |url|

    doc = Nokogiri::HTML(open(url))
    doc.css(".subtitleLink b").each do |item|
      Place.create!(:name => item.text.strip, :city => "Sterling", 
                                              :zipcode => "",
                                              :state => "VA",
                                              :category => "Masjid")    
        end
    end 
  end