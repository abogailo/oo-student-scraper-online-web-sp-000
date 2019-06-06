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
    students_hash = {}


     html = Nokogiri::HTML(open(profile_url))
    html.css("div.social-icon-controler a").each do |student|
        url = student.attribute("href")
        students_hash[:twitter_url] = url if url.include?("twitter")
        students_hash[:linkedin_url] = url if url.include?("linkedin")
        students_hash[:github_url] = url if url.include?("github")
        students_hash[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
    end
        students_hash[:profile_quote] = html.css("div.profile-quote").text
        students_hash[:bio] = html.css("div.bio-content p").text
    students_hash
  end

end
