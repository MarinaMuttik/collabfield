require 'rails_helper'

RSpec.describe Private::Conversation, type: :model do
  context 'Associations' do
    it 'belongs_to sender' do
      association = described_class.reflect_on_association(:sender).macro
      expect(association).to eq :belongs_to
    end

    it 'belongs_to recipient' do
      association = described_class.reflect_on_association(:recipient).macro
      expect(association).to eq :belongs_to
    end

    it 'has_many messages' do
      association = described_class.reflect_on_association(:messages)
      expect(association.macro).to eq :has_many
    end
  end

  context 'Scopes' do
    it 'gets a conversation between users' do
      user1 = create(:user)
      user2 = create(:user)
      create(:private_conversation, recipient_id: user1.id, sender_id: user2.id)
      conversation = Private::Conversation.between_users(user1.id, user2.id)
      expect(conversation.count).to eq 1
    end
  end

  context 'Methods' do
    it 'gets the opposed user' do
      user1 = create(:user)
      user2 = create(:user)
      conversation = create(:private_conversation,
                            recipient_id: user1.id,
                            sender_id: user2.id)
      opposed_user = conversation.opposed_user(user1)
      expect(opposed_user).to eq user2
    end
  end
end
