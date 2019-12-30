class Website < ApplicationRecord

  validates :host_url, uniqueness: true

  def self.crawl_website(url)
    parsed_url_details = Nokogiri::HTML(HTTParty.get(url))

    links = parsed_url_details.css('a').map { |link| link['href'] }

    sub_links = extract_links(url, links)

    add_or_update_record(url, sub_links)
  end

  def self.extract_links(url, links)
    sub_links = []

    links.map do |link|
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
    return sub_links.compact.uniq
  end

  def self.add_or_update_record(url, sub_links)
    website = Website.where(host_url: url).first_or_initialize
    website.sub_links = sub_links
    website.total_sub_links = sub_links.count
    website.save
    return website
  end
end
