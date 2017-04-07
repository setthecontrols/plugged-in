class Boardcategories < ApplicationRecord
  has_many :boardposts

  validates :name, presence: true
end
