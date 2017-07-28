require 'acts_as_votable'
class Newsitem < ApplicationRecord
  belongs_to :level
  acts_as_votable

  def to_s
    "Newsitem #{id} - #{name}"
  end

  def get_interest_score(userid)

  	# Interest score is computed as the sum of the following:
  	# age : -inf .. 100, where 100 is age 0, 90 is a day old, 60, a week old, 0 three months old
  	# vote ratio : -100 .. +100 for all down/up votes
  	# vote count : 0 .. 100, where 50 is for 20 votes, 100 for inf votes
  	# interest tags : -100 .. +100 per tag
  	# positive scores are more interesting, but returned as negated for sorting
  	# 
  	puts "==================================================================="
  	puts "Get interest score for user #{userid} post #{id}, #{name}:"

  	# age
  	# 200/math.log10(10.0+float(x)/day)-100

  	secs_per_day = 60*60*24.0
  	age_in_days = (Time.zone.now-created_at) / secs_per_day
  	puts "Age: #{age_in_days} days"
  	age_score = 200.0 / Math.log10(10.0 + age_in_days) - 100
  	puts "Age score: #{age_score}"

  	# vote ratio

  	total_votes = votes_for.size
  	puts "Total votes: #{total_votes}"
  	if total_votes > 0 then
	  puts "Upvotes: #{get_up_votes.size}"
  	  puts "Downvotes: #{get_down_votes.size}"
  	  vote_ratio_score = 100.0 * (get_up_votes.size - get_down_votes.size) / votes_for.size
  	else
  	  vote_ratio_score = 0
  	end
  	puts "Vote ratio score: #{vote_ratio_score}"

  	# vote count
  	# 70+30*(1-1/math.log10(2+x/10.))

    if total_votes > 0 then
	  adj_total_votes = 2 + total_votes / 10.0
	  log_total_votes = Math.log10(adj_total_votes)
	  inv_total_votes = 1.0 / log_total_votes
	  neg_total_votes = 1.0 - inv_total_votes
	  vote_count_score = 70 + 30 * neg_total_votes
	else
	  vote_count_score = 0
	end
  	puts "Vote count score: #{vote_count_score}"

  	# interest tags

  	tag_score = 0
  	taglist = tags ? tags.split(" ") : []
  	puts "Tags on post: #{taglist}"
  	taglist.each do |tag_name|
  	  tag = Tag.find_by(name: tag_name)
  	  if tag then
        interest = UserInterest.find_by(id: userid*1000+tag.id)
  	    if interest then 
  	  	  puts "Tag #{tag_name} score: #{10*interest.weight}"
  	  	  tag_score += 10*interest.weight
  	  	else
  	  	  puts "No user interest for tag #{tag_name}"
  	  	end
  	  else
  	  	puts "Tag in post (#{tag_name}) not in tag table"
  	  end
  	end

  	# sum

  	score = age_score + vote_ratio_score + vote_count_score + tag_score

  	puts "Total score: #{score}"
  	-score
  end
end