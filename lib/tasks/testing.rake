desc "testing data"
task :testing => :environment do
  
  require 'nokogiri'
  require 'open-uri'
  require 'mechanize'

  agent = Mechanize.new

  page = agent.get("http://www.salatomatic.com/c/Birmingham+12")    
  
                #loops through all places in each region  
                  page.search('.subtitleLink a').map{|a| page.uri.merge a[:href]}.each do |uri|
                    begin
                     page4 = agent.get uri
                      puts page4.at('.titleBM').text
                      puts page4.at('.titleBM').next.text
                      
                      name = page4.at('.titleBM').text
                      addy = page4.at('.titleBM').next.text
                      more_info = page4.at('.normalLink').text
                      page5 = page4.link_with(:text => "Click here").click
                      website = page5.uri.to_s
                      
                      
                      street, city, state, zip = addy.match(/(.*), (.*), ([A-Z]{2}) (\d{5})/).captures
                      phone = more_info.match(/(\D\d{3}\D\s\d{3}\D\d{4})/).captures                      
                      puts phone
                      puts website
                                            
                      Place.create!(:name => name.strip, 
                                    :address => street.strip,
                                    :city => city.strip,
                                    :state => state.strip,
                                    :zipcode => zip.strip,
                                    :phone => phone[0].strip,
                                    :website => website,
                                    :category => "Masjid",
                                    :description => "Normal masjid")
                      
                    rescue
                      next
                 
            end             
      end
    
end