class HomeController < ApplicationController

  require 'open-uri'
  require 'nokogiri'

  def index
    url = 'https://www.bbc.co.uk'
    # url.last('//')
    # url = 'https://www.digitalocean.com'
    @website = Website.crawl_website(url)
  rescue StandardError => e
    flash[:error] = e
  end

end
