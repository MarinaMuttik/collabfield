class ApplicationController < ActionController::Base
  def redirect_if_not_signed_in
    redirect_to root_path if !user_signed_in?
  end

  def redirect_if_signed_in
    redirect_to root_path if user_signed_in?
  end

  before_action :opened_conversation_windows

  def opened_conversation_windows
    if user_signed_in?
      # opened convos
      session[:private_conversations] ||= []
      @private_conversations_windows = Private::Conversation
                                       .includes(:recipient, :messages)
                                       .find(session[:private_conversations])
    else
      @private_conversations_windows = []
    end
  end
end
