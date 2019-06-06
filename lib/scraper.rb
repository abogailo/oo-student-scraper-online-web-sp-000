require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

   scraped_students = []

  doc.css(".student-card").each do |student|
   scraped_students << {
     name: student.css("h4.student-name").text,
     location: student.css("p.student-location").text,
     profile_url: "http://students.learn.co/#{student.css("a").attribute("href").value}"
   }
 end
 scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
