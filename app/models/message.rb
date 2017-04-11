class Message < ApplicationRecord
  after_create_commit { MessageBraodcastJob.perform_later self }
  belongs_to :conversation
  belongs_to :user
end
