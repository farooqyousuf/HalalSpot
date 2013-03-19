desc "testing data"
task :testing2 => :environment do
  
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
                      puts page4.at('.titleBM').text
                      puts page4.at('.titleBM').next.text
                      
                      name = page4.at('.titleBM').text
                      addy = page4.at('.titleBM').next.text
                      street, city, state, zipcode = addy.match(/(.*), (.*), ([A-Z]{2}) (\d{5})/).captures
                      
                      Place.create!(:name => name.strip, 
                                    :address => street.strip,
                                    :city => city.strip,
                                    :state => state.strip,
                                    :zipcode => zipcode.strip,
                                    :category => "Masjid",
                                    :description => "Normal masjid")
                      
                    rescue
                      next
                    end
                    
                  end
            end             
      end
    
end