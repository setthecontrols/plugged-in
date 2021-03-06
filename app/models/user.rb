class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar,

                    styles: { large: "600x600>", medium: "300x300>", small: "100x100>", thumb: "150x150#" },
                    url: "/assets/:style/:attachment/:style.:extension"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :user_conversations
  has_many :conversations, through: :user_conversations
  has_many :messages
  has_many :connections
  has_many :connected_users, through: :connections
  has_many :useraudiofiles
  has_many :boardposts
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

  def unread_messages
    unreads = []
    self.user_conversations.each do |uc|
      uc.unread_messages.each do |message|
        unreads << message
      end
    end
    return unreads
  end

  def find_convo(user)
    self.conversations.each do |convo|
      if convo.other_user(self) == user
        return convo
      end
    end
    nil
  end

  def has_convo?(user)
    self.conversations.each do |convo|
      if convo.other_user(self) == user
        return true
      end
    end
    false
  end

  def possible_connections
    @CU = self.connected_users
    @CUC = []
    @CU.each do |user|
      @CUC << user.connected_users
    end
    @CUC.flatten!
    @CUC = @CUC.select {|user| user != self || !@CU.include?(user)}
    @CUC.shuffle!
    @top_CUC = @CUC[0..4]
    @top_CUC.uniq!
    # i = 5
    # until(@top_CUC.length == 5 || @top_CUC == @CUC.uniq) do
    #   @top_CUC << @CUC[i]
    #   @top_CUC.uniq!
    #   i += 1
    # end
    return @top_CUC
  end
end
