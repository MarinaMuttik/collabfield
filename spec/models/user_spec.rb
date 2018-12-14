require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Associations' do
    it 'has_many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end

  context 'Validations' do
    let(:user1) { build(:user) }
    let(:user2) { User.new }

    # test new account without username
    it "is not valid without a username" do
      user1.name = nil
      expect(user1).not_to be_valid
    end

    # test duplicate usernames
    it 'can only create unique user names' do
      user1.name = 'test1'
      user2.name = 'test1'
      expect(user1).to be_valid
      expect(user2).not_to be_valid
    end
  end
end
