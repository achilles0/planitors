class Level < ApplicationRecord
  has_many :missions
  has_many :users

  def to_s
    "Level #{id} - #{name}"
  end
end
