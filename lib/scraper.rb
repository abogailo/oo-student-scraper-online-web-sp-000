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
  end	    student = Hash.new


     social_icons = doc.css("div.social-icon-container a").collect {|x| x.attribute("href").value}
    social_icons.each do |social_icon|
      if social_icon.include?("linkedin")
        student[:linkedin] = social_icon
      elsif social_icon.include?("github")
        student[:github] = social_icon
      elsif social_icon.include?("twitter")
        student[:twitter] = social_icon
      else
        student[:blog] = social_icon
      end
    end
    # if doc.css("div.bio-content.content-holder div.description-holder p")
      student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    # end
    # if doc.css(".profile-quote")
      student[:profile_quote] = doc.css(".profile-quote").text
    # end
    student
  end

end
