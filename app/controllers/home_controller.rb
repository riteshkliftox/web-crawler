class HomeController < ApplicationController

  require 'open-uri'
  require 'nokogiri'

  def index
    url = 'https://www.bbc.co.uk'
    # url = 'https://www.digitalocean.com'
    doc = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(doc)

    @links = parsed_page.css('a').map { |link| link['href'] }
    
    sub_links = []

    @links.map do |link|
      if link.include?(url)
        splited_links = link.split(url)
        next if splited_links[1]&.first&.eql?('#')

        sub_links << splited_links[1]
      else
        next if link.include?('http')
        next if link.first.eql?('#')
        
        sub_links << link
      end
    end
    @sub_links = sub_links.compact.uniq
  end

end
