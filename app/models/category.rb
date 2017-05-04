class Category < ApplicationRecord
  has_many :missions

  def to_s
    name
  end
end
