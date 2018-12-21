require 'rails_helper'

RSpec.describe Private::MessagesHelper, :type => :helper do
  context '#private_message_date_check' do
    let(:message) { create(:private_message) }
    let(:previous_message) { create(:private_message) }

    it 'returns new date partial' do
      previous_message.update(created_at: 2.days.ago)
      expect(helper.private_message_date_check(message, previous_message)).to(
        eq 'private/messages/message/new_date'
      )
    end

    it 'returns an empty partial path' do
      expect(helper.private_message_date_check(message, previous_message)).to(
        eq 'shared/empty_partial'
      )
    end

    it 'returns an empty partial path' do
      previous_message = nil
      expect(helper.private_message_date_check(message, previous_message)).to(
        eq 'shared/empty_partial'
      )
    end
  end

  context '#sent_or_received' do
    let(:user) { create(:user) }
    let(:message) { create(:private_message) }

    it 'returns a message sent class' do
      message.update(user_id: user.id)
      expect(helper.sent_or_received(message, user)).to(
        eq 'message-sent'
      )
    end

    it 'returns a message received class' do
      expect(helper.sent_or_received(message, user)).to(
        eq 'message-received'
      )
    end
  end

  context '#seen_or_unseen' do
    let(:message) { create(:private_message) }

    it 'returns an unseen class' do
      message.update(seen: false)
      expect(helper.seen_or_unseen(message)).to(
        eq 'unseen'
      )
    end

    it 'returns an empty class' do
      message.update(seen: true)
      expect(helper.seen_or_unseen(message)).to(
        eq ''
      )
    end
  end

  context '#replace_link_to_private_messages_partial_path' do
    it 'returns a replace link partial path' do
      expect(helper.replace_link_to_private_messages_partial_path).to(
        eq 'private/messages/load_more_messages/window/replace_link_to_messages'
      )
    end
  end
end
