namespace :hs do
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
                        
                        
                        street, city, state, zipcode = addy.match(/(.*), (.*), ([A-Z]{2}) (\d{5})/).captures
                        phone = more_info.match(/(\D\d{3}\D\s\d{3}\D\d{4})/).captures                      
                        puts phone
                        puts website
                                              
                        Place.create!(:name => name.strip, 
                                      :address => street.strip,
                                      :city => city.strip,
                                      :state => state.strip,
                                      :zipcode => zipcode.strip,
                                      :phone => phone[0].strip,
                                      :website => website,
                                      :category => "Masjid",
                                      :description => "No one has entered a description yet, feel free to add one if you know it!")
                        
                      rescue
                        next
                   
              end             
        end
      
  end
end