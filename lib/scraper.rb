require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_hash = []
doc.css("div.roster-cards-container").each do |card|
    doc.css(".student-card").each do |student|
      student_hash << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "#{student.attr("href")}"
      }
    end
  end
    student_hash
  end

  def self.scrape_profile_page(profile_url)

  end

end
