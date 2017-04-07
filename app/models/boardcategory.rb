class Boardcategory < ApplicationRecord
  has_many :boardposts

  validates :name, presence: true

  paginates_per 15
end
