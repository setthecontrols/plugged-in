class Boardpost < ApplicationRecord
  belongs_to :user
  belongs_to :boardcategory
  has_many :post_tags
  has_many :tags, through: :post_tags

  has_attached_file :image, styles: { large: "600x600", medium: "300x300", thumb: "150x150" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :title, :content, presence: true

  paginates_per 25
end
