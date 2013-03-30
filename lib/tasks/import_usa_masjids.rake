namespace :hs do
  desc "Imports all masjids in USA "
  task :import_usa_masjids => :environment do
    
    require 'nokogiri'
    require 'open-uri'
    require 'mechanize'

    agent = Mechanize.new

    page = agent.get("http://www.salatomatic.com/b/United-States+125")    
    
      #loops through all state links
      page.search('.subtitleLink a').map{|a| page.uri.merge a[:href]}.each do |uri|
        
          page2 = agent.get uri
        
              #loops through all regions in each state
              
                page2.search('.subtitleLink a').map{|a| page2.uri.merge a[:href]}.each do |uri|
                  page3 = agent.get uri

                  #loops through all places in each region  
                    page3.search('.subtitleLink a').map{|a| page3.uri.merge a[:href]}.each do |uri|
                      begin
                       page4 = agent.get uri
                        # puts page4.at('.titleBM').text
                        #                         puts page4.at('.titleBM').next.text
                        
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
                                      :category => "Masjid",
                                      :description => description.strip)
                        
                      rescue
                        next
                      end
                      
                    end
              end             
        end
      
  end
end