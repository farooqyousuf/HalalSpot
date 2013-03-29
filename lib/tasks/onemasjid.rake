namespace :hs do
  desc "This rake task imports 1 masjid only"
  task :onemasjid => :environment do
    
    require 'nokogiri'
    require 'open-uri'
    require 'mechanize'
 
    agent = Mechanize.new
    
    puts "Enter the page url from which you wish to import data: "
    page3 = STDIN.gets
    # page2 = Nokogiri::HTML(open(page))
    # page2 = agent.get(page)  
    # page = agent.get("http://www.salatomatic.com/c/Southwest-Houston+82")    
    
                  #loops through all places in each region  
                    # links = page2.css('.subtitleLink a')# .each do |x|
                    #                         
                    #                         links.each do |link| 
                    #                           puts link['href']
                    #                           url = link['href'].strip
                        
                        # x.map{|a| page2.uri.merge a[:href]}.each do |uri|
                        # blah = URI.parse(x)
                        #                         page4 = Nokogiri::HTML(open(URI.encode(x.to_s.strip)))
                        page4 = agent.get(page3)
                        puts page4.uri
                        
                        # Nokogiri::HTML(open(link['href'])).each do |page4|                      
                       

                      begin
                        # puts page4.at('.titleBM').text
                        # puts page4.at('.titleBM').next.text
                                                
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
                   # end
          end             
  end
end