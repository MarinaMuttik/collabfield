module Private::MessagesHelper
  def private_message_date_check(message, previous_message)
    if defined?(previous_message) && previous_message.present?
      # messages not from same day
      if previous_message.created_at.to_date != message.created_at.to_date
        @message = message
        'private/messages/message/new_date'
      else
        'shared/empty_partial'
      end
    else
      'shared/empty_partial'
    end
  end

  def sent_or_received(message, user)
    if user.id == message.user_id
      'message-sent'
    else
      'message-received'
    end
  end

  def seen_or_unseen(message)
    if message.seen == false
      'unseen'
    else
      ''
    end
  end
end
