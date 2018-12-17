module Private::ConversationsHelper
  def private_conv_recipient(conversation)
    conversation.opposed_user(current_user)
  end
end
