require 'acts_as_votable'
class Newsitem < ApplicationRecord
  belongs_to :level
  acts_as_votable

  def to_s
    "Newsitem #{id} - #{name}"
  end
end