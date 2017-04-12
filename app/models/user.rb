class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar,
                    styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" },
                    url: "/assets/:style/:attachment/:style.:extension"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  has_many :messages
  has_many :connections
  has_many :connected_users, through: :connections
  has_many :useraudiofiles
  has_many :boardposts
  has_many :conversations
  has_many :dragonflymedia
  has_many :locations

  # validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def full_name
    if first_name != nil && last_name != nil
    first_name + " " + last_name
    else
      username
    end
  end

  def find_location
    locations = Location.order(created_at: :desc)
    locations.find_by(user_id: self.id)
  end

  def self.create_with_omniauth(auth)

    user = find_or_create_by(uid: auth['uid'], provider:  auth['provider'])
    user.email = "#{auth['uid']}@#{auth['provider']}.com"
    user.password = auth['uid']
    user.name = auth['info']['name']
    if User.exists?(user)
      user
    else
      user.save!
      user
    end
  end

end
