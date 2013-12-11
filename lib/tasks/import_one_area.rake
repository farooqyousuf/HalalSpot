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
    
                  #loops through all places in each region  
                    page2.search('.subtitleLink a').map{|a| page2.uri.merge a[:href]}.each do |uri|
                      
                      begin
                      
                      page4 = agent.get uri
                                                
                        name = page4.at('.titleBM').text
                        puts name
                        
                        addy = page4.at('.titleBM').next.text
                        street, city, state, zipcode = addy.match(/(.*), (.*), ([A-Z]{2}) (\d{5}|\s*)/).captures
                        puts addy
                        
                        description = page4.at('hr').next.text
                        puts description
                        
                        more_info = page4.at('.normalLink').text
                        
                        if more_info.match(/(\s*\D\d{3}\s*\D\s*\d{3}\s*\D\s*\d{4}\s*)/).present?
                          ph = more_info.match(/(\s*\D\d{3}\s*\D\s*\d{3}\s*\D\s*\d{4}\s*)/).captures
                          phone = ph[0]
                        else
                          phone = "-"
                        end
                              
                        puts phone
                        
                        if page4.link_with(:text => "Click here").present?
                          
                          begin
                            page5 = page4.link_with(:text => "Click here").click  
                            if page5.present?
                              website = page5.uri.to_s
                            else  
                              website = ""
                            end
                            rescue Exception
                          end
                        
                        else
                          website = ""  
                        end  
                          
                        puts website
                        
                        puts "**********"
                                              
                        Place.create!(:name => name.strip, 
                                      :address => street.strip,
                                      :city => city.strip,
                                      :state => state.strip,
                                      :zipcode => zipcode.strip,
                                      :phone => phone.strip,
                                      :website => website,
                                      :category => "Restaurant",
                                      :description => description.strip)              
                        
                      rescue
                        next
                      end
              end             
        end
      
  end
