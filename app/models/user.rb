class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  belongs_to :level

  has_many :accepted_missions

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
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
