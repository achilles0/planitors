class Mission < ApplicationRecord
  belongs_to :category
  belongs_to :level
  has_many :accepted_missions
  has_many :users, through: :accepted_missions

  def finished_by_user(user)
    accepted_missions.where(user: user, finished: true).any?
  end
end
