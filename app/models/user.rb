class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }, default_url: "/assets/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_attached_file :audio_file
  # validates_attachment_content_type :audio, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]


  has_many :boardposts
  has_many :conversations
  has_many :dragonflymedia

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def full_name
    first_name + " " + last_name
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
