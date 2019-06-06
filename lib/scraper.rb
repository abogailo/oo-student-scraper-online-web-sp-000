require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_hash = []

    doc.css(".student-card").each do |student|
      student_hash << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "http://students.learn.co/#{student.css("a").attribute("href").value}"
      }
    end
    student_hash
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

