class AcceptedMission < ApplicationRecord
  belongs_to :user
  belongs_to :mission

  # These should really be in a presenter only
  delegate :name, :icon, :text, :co2, :continuous?, :category, :difficulty, :duration, :level, to: :mission
end
