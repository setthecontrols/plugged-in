class Boardpost < ApplicationRecord
  belongs_to :user
  belongs_to :boardcategory

  validates :title, :content, presence: true
end
