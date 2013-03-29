namespace :hs do
  desc "This rake task imports 1 geographic area only"
  task :import_one_area => :environment do
    
    require 'nokogiri'
    require 'open-uri'
    require 'mechanize'

    agent = Mechanize.new
    
    puts "Enter the page url from which you wish to import data: "
    page = STDIN.gets
    page2 = agent.get(page)  
    # page = agent.get("http://www.salatomatic.com/c/Southwest-Houston+82")    
    
                  #loops through all places in each region  
                    page2.search('.subtitleLink a').map{|a| page2.uri.merge a[:href]}.each do |uri|
                      begin
                       page4 = agent.get uri
                        # puts page4.at('.titleBM').text
                        # puts page4.at('.titleBM').next.text
                                                
                        name = page4.at('.titleBM').text
                        addy = page4.at('.titleBM').next.text
                        description = page4.at('hr').next.text.strip
                        
                        more_info = page4.at('.normalLink').text
                        page5 = page4.link_with(:text => "Click here").click
                        website = page5.uri.to_s
                        
                        
                        street, city, state, zipcode = addy.match(/(.*), (.*), ([A-Z]{2}) (\d{5})/).captures
                        phone = more_info.match(/(\D\d{3}\D\s\d{3}\D\d{4})/).captures                      
                        
                        puts name
                        puts addy
                        puts phone
                        puts website
                        puts description
                        puts "**********"
                                              
                        Place.create!(:name => name.strip, 
                                      :address => street.strip,
                                      :city => city.strip,
                                      :state => state.strip,
                                      :zipcode => zipcode.strip,
                                      :phone => phone[0].strip,
                                      :website => website,
                                      :category => "Masjid",
                                      :description => description)              
                        
                      rescue
                        next
                   
              end             
        end
      
  end
end