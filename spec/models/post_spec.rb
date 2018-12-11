require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end

    it 'belongs_to category' do
      association = described_class.reflect_on_association(:category).macro
      expect(association).to eq :belongs_to
    end
  end

  context 'default_scope' do
    it 'orders by created at descending by default' do
      post1 = create(:post)
      post2 = create(:post)
      expect(Post.all).to eq [post2, post1]
    end
  end
end
