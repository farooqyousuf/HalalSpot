desc "testing data"
task :testing => :environment do
  
    require 'nokogiri'
    require 'open-uri'
    require 'mechanize'

    agent = Mechanize.new
    
    page = agent.get("http://www.salatomatic.com/c/Birmingham+12")
    
      	page.search('.subtitleLink a').map{|a| page.uri.merge a[:href]}.each do |uri|
  			 page2 = agent.get uri
            puts page2.at('.titleBM')
            # puts doc.css(".titleBM").text.strip
            
            
            
  			end
    
     
  end