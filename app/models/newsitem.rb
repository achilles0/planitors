class Newsitem < ApplicationRecord
  belongs_to :level

  def to_s
    "Newsitem #{id} - #{name}"
  end
end