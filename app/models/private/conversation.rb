class Private::Conversation < ApplicationRecord
  self.table_name = 'private_conversations'

  has_many :messages,
           class_name: 'Private::Message',
           foreign_key: :conversation_id
  belongs_to :sender,
             foreign_key: :sender_id,
             class_name: 'User'
  belongs_to :recipient,
             foreign_key: :recipient_id,
             class_name: 'User'

  scope :between_users, -> (user1_id, user2_id) do
    where(sender_id: user1_id, recipient_id: user2_id).or(
      where(sender_id: user2_id, recipient_id: user1_id)
    )
  end

  def create
    recipient_id = Post.find(params[:post_id]).user.id
    conversation = Private::Conversation.new(sender_id: current_user.id,
                                             recipient_id: recipient_id)
    if conversation.save
      Private::Message.create(user_id: recipient_id,
                              conversation_id: conversation.id,
                              body: params[:message_body])
      respond_to do |format|
        format.js { render partial: 'posts/show/contact_user/success' }
      end
    else
      respond_to do |format|
        format.js { render partial: 'posts/show/contact_user/failure' }
      end
    end
  end
end
