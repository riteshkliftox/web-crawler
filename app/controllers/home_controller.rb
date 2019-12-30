class HomeController < ApplicationController

  require 'open-uri'
  require 'nokogiri'

  def index
    url = params[:domain].delete_suffix('/')

    @website = Website.crawl_website(url) if url.present?
  rescue StandardError => e
    flash[:error] = e
  end

end
