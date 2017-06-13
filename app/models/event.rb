class Event < ApplicationRecord
  has_many :attendees, class_name: :user, foreign_key: :attendee_id
  has_many :invitees, class_name: :user, foreign_key: :invitee_id
  belongs_to :host, class_name: :user, foreign_key: :host_id

end
