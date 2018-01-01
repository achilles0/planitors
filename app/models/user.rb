class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  belongs_to :level

  has_many :accepted_missions
  has_many :tags, through: :user_interests

  has_many :missions, through: :accepted_missions do
    def available
      Mission.all.joins("left outer JOIN `accepted_missions` ON `accepted_missions`.`mission_id` = `missions`.`id` and (accepted_missions.user_id = #{proxy_association.owner.id}) and level_id = #{proxy_association.owner.level_id}").where("accepted_missions.user_id IS NULL")
      # See https://github.com/rails/rails/pull/12071#issuecomment-41401056 for a possibly nicer syntax for this in the future
    end
  end

  def finished_missions_by_level(lvl)
    accepted_missions.where(finished: true).joins(:mission).where(missions: { level: lvl })
  end

  def progress(lvl: nil, percentage: false)
    lvl ||= self.level
    missions_in_level = [Mission.where(level: lvl).count, 1].max # Div by 0 protection
    decimal = (finished_missions_by_level(lvl).count.to_f / missions_in_level).round(2)
    return decimal unless percentage
    (decimal * 100).to_i
  end

  def co2_reduction_from_missions
    missions.sum(:co2) #* 0.001 # convert from tons to kg
  end

  def co2_budget(percentage: false)
    return 1500.0 / 365 unless percentage
    ((1500.0 / 365 / default_co2_impact) * 100).to_i
  end

  def default_co2_impact
    7000.0 / 365
  end

  def co2_impact
    default_co2_impact - co2_reduction_from_missions
  end

  def co2_result(percentage: false)
    result = (co2_impact - co2_budget).round(2)
    percentage ? ((result / default_co2_impact) * 100).to_i : result
  end

  # https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
  def self.from_omniauth(auth)
    puts "In from_omniauth"
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
      puts "In from_omniauth: #{user}"
      user.deliver_welcome_message
    end
  end

  def deliver_welcome_message
    msg = Message.new
    msg.to_user_id = self.id
    msg.from_user_id = 1 ## FIXME: Happy
    msg.subject = "Congratulations, new level! Welcome to level 1"
    # FIXME: where should this be stored, really?
    msg.text = <<END
    Welcome to level 1 of All For Eco!

    This is a kind of game and meeting place for all who care about out the single planet all of us have to share. 
    The game is divided into levels, where each new level unlocks some new features of the platform. You level up
    by accepting and completing missions. All For Eco is also the place to look for news, tips and advice related
    to saving the climate, bio diversity (that there are many kinds of animals and life forms on the planet), the
    purity of our skies and waters, and actually all the 17 developemnt goals that United Nations have agreed on.

    All For Eco is still in its infancy, as you will surely realize soon. We're very happy you want to take part
    in this journey with us, and develop a platform for a thriving community to enjoy. All For Eco is developed by
    a not-for profit organizaton by the same name.

    Enjoy, and do let us know what you think!
      /Jan Lindblad
END
    msg.sent_at = Time.now
    msg.save!
    puts "In deliver_welcome_message: #{msg}"
  end

  def streak?
    # select created_at from newsitems where created_by=3 order by created_at desc limit 1;
    day_streak = week_streak = month_streak = 0
    last_newsitem = Newsitem.find_by_sql [
        "select created_at from newsitems where created_by=? order by created_at desc limit 1", self.id]
    if last_newsitem.count >= 1 then
      last_post_date = Time.at(last_newsitem.first.created_at).to_date
      if NewsitemsController.is_today? last_post_date or NewsitemsController.is_yesterday? last_post_date then 
        day_streak = streak_d ? streak_d : 0
      end
      if NewsitemsController.is_this_week? last_post_date or NewsitemsController.is_last_week? last_post_date then 
        week_streak = streak_w ? streak_w : 0
      end
      if NewsitemsController.is_this_month? last_post_date or NewsitemsController.is_last_month? last_post_date then 
        month_streak = streak_m ? streak_m : 0 
      end
    end
    return {"day" => day_streak, "week" => week_streak, "month" => month_streak, "total" => day_streak + week_streak + month_streak }
  end
end
