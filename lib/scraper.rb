require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    student_hash = []

    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_hash << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "#{student.attr("href")}"
        }
      end
    end
    student_hash
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}

    doc.css(".social-icon-container a").each do |link|
      normalized_link = link.attribute("href").text

      scraped_student[:twitter] = normalized_link if normalized_link.include?("twitter")
      scraped_student[:linkedin] = normalized_link if normalized_link.include?("linkedin")
      scraped_student[:github] = normalized_link if normalized_link.include?("github")
      scraped_student[:blog] = normalized_link if link.css("img").attribute("src").text.include?("rss")
    end

     scraped_student[:profile_quote] = doc.css(".profile-quote").text
     scraped_student[:bio] = doc.css("bio-content .description-holder p").text

     scraped_student
  end

end
