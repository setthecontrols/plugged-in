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
  def all_feeds
    @feed = []
    bp = self.create_boardpost_feed
    cf = self.create_connects_feed
    au = self.create_audio_upload_feed
    au.each {|a| @feed << a}
    cf.each {|c| @feed << c}
    bp.each {|p| @feed << p}
    @feed.flatten!
    @feed.sort! {|b, a| b.created_at <=> a.created_at}
    return @feed
  end

  def create_boardpost_feed
    bp = []
    c_ids = []
    connects = self.connections
    connects.each {|conns| c_ids << conns.connected_user_id}
    c_ids.each  {|id| bp << Boardpost.where(user_id: id)}
    bp.flatten!
    bp.sort!{|b, a| a.created_at <=> b.created_at}

  end

  def create_connects_feed
    c = []
    c_ids = []
    connects = self.connections
    connects.each {|conns| c_ids << conns.connected_user_id}
    c_ids.each  {|id| c << Connection.where(user_id: id)}
    c.flatten!
    c.sort!{|b, a| a.created_at <=> b.created_at}

  end

  def create_audio_upload_feed
    af = []
    c_ids = []
    connects = self.connections
    connects.each {|conns| c_ids << conns.connected_user_id}
    c_ids.each  {|id| af << Useraudiofile.where(user_id: id)}
    af.flatten!
    af.sort!{|b, a| a.created_at <=> b.created_at}
  end

  def self.user_feed_audio_file
    my_users = self.connected_users

    my_users.each do |user|
      Useraudiofile.find_by(user_id: user.id)
      # user.connected_users
      # Boardpost.find_by(user_id: user.id)
    end
  end

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
