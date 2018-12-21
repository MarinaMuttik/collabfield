require 'active_support/concern'

module Messages
  extend ActiveSupport::Concern

  def get_messages(conversation_type, messages_amount)
    # convert string to constant to call model dynamically
    model = "#{conversation_type.capitalize}::Conversation".constantize
    @conversation = model.find(params[:conversation_id])
    # get previous messages in convo
    @messages = @conversation.messages.order(created_at: :desc)
                                      .limit(messages_amount)
                                      .offset(params[:messages_to_display_offset].to_i)
    # set variable to get more previous messages
    @messages_to_display_offset = params[:messages_to_display_offset].to_i + messages_amount

    @type = conversation_type.downcase
    # if messages are last, mark variable as 0 so load messages is removed
    if @conversation.messages.count < @messages_to_display_offset
      @messages_to_display_offset = 0
    end
  end
end
