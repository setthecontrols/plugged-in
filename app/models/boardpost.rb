class Boardpost < ApplicationRecord
  belongs_to :user
  belongs_to :boardcategory

  validates :title, :content, presence: true

  paginates_per 25
end
