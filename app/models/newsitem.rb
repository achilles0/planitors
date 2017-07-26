require 'acts_as_votable'
class Newsitem < ApplicationRecord
  belongs_to :level
  acts_as_votable

  def to_s
    "Newsitem #{id} - #{name}"
  end

  def get_interest_score
  	puts 1
  	user = 3 # TODO
  	score = 0
  	taglist = tags ? tags.split(" ") : []
  	puts taglist
  	taglist.each do |tag_name|
  	  tag = Tag.find_by(name: tag_name)
  	  if tag then
        interest = UserInterest.find_by(id: user*1000+tag.id)
  	    if interest then 
  	  	  puts "Tag #{tag_name} adding score #{interest.weight.to_s}"
  	  	  score += interest.weight 
  	  	end
  	  end
  	end
  	score
  end
end