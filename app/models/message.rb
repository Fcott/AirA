class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :context, :conversation_id, :user_id

  def message_time
    created_at.strftime("%c")
  end
end
