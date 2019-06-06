require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     doc = Nokogiri::HTML(open(index_url))

    student_hash = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = "#{student.attr("href")}"
        student_hash << {name: name, location: location, profile_url: profile_url}
      end
    end
    student_hash
  end

  def self.scrape_profile_page(profile_url)

  end

end
