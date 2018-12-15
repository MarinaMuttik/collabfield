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

  context 'Scopes' do
    it 'default_scope orders by created at descending' do
      post1 = create(:post)
      post2 = create(:post)
      expect(Post.all).to eq [post2, post1]
    end

    it 'by_branch gets posts from particular branch' do
      category = create(:category)
      create(:post, category_id: category.id)
      create_list(:post, 10)
      posts = Post.by_branch(category.branch)
      expect(posts.count).to eq 1
      expect(posts[0].category.branch).to eq category.branch
    end

    it 'by_category gets posts from particular category' do
      category = create(:category)
      create(:post, category_id: category.id)
      create_list(:post, 10)
      posts = Post.by_category(category.branch, category.name)
      expect(posts.count).to eq 1
      expect(posts[0].category.name).to eq category.name
    end

    it 'search gets posts from input' do
      post = create(:post, title: 'test title', content: 'fun stuff' * 3)
      create_list(:post, 10)
      title_posts = Post.search('test')
      expect(title_posts.count).to eq 1
      expect(title_posts[0].id).to eq post.id
      content_posts = Post.search('fun')
      expect(content_posts.count).to eq 1
      expect(content_posts[0].id).to eq post.id
    end
  end

  context 'Validations' do
    let(:post) { build(:post) }

    it 'creates successfully' do
      expect(post).to be_valid
    end

    it 'is not valid without category' do
      post.category_id = nil
      expect(post).not_to be_valid
    end

    it 'is not valid without a user_id' do
      post.user_id = nil
      expect(post).not_to be_valid
    end

    it 'is not valid without a title' do
      post.title = nil
      expect(post).not_to be_valid
    end

    it 'is not valid with title shorter than 3' do
      post.title = 'a' * 2
      expect(post).not_to be_valid
    end

    it 'is not valid with title longer than 200' do
      post.title = 'a' * 201
      expect(post).not_to be_valid
    end

    it 'is not valid without content' do
      post.content = nil
      expect(post).not_to be_valid
    end

    it 'is not valid with content shorter than 20' do
      post.content = 'a' * 19
      expect(post).not_to be_valid
    end

  end
end
