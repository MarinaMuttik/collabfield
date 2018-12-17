require 'rails_helper'

RSpec.describe Private::ConversationsHelper, :type => :helper do
  context '#private_conv_recipient' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:conversation) { create(:private_conversation,
                         recipient_id: user1.id,
                         sender_id: user2.id) }
    it 'returns the private conversation recipient' do
      allow(helper).to receive(:current_user).and_return(user1)
      expect(helper.private_conv_recipient(conversation)).to eq user2
    end
  end

  context '#load_private_messages' do
    let(:conversation) { create(:private_conversation) }

    it 'returns load_messages partial path' do
      create(:private_message, conversation_id: conversation.id)
      expect(helper.load_private_messages(conversation)).to eq(
        'private/conversations/conversation/messages_list/link_to_previous_messages'
      )
    end

    it 'returns an empty partial path' do
      expect(helper.load_private_messages(conversation)).to eq(
        'shared/empty_partial'
      )
    end
  end
end
