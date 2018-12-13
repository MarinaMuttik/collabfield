require 'rails_helper'
require './app/services/posts_for_branch_service.rb'

describe PostsForBranchService do
  context '#call' do
    let(:not_included_posts) { create_list(:post, 2) }
    let(:category) { create(:category, branch: 'hobby', name: 'arts') }
    let(:post) do
      create(:post, title: 'test title', category_id: category.id)
    end

    it 'returns posts filtered by branch' do
      not_included_posts
      category
      included_posts = create_list(:post, 2, category_id: category.id)
      expect(PostsForBranchService.new(branch: 'hobby').call).to(
        match_array included_posts
      )
    end

    it 'returns posts filtered by branch and search' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new(
        { branch: 'hobby', search: 'test' }
      ).call).to(eq included_post)
    end

    it 'returns posts filtered by branch and category' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new(
        { branch: 'hobby', category: 'arts' }
      ).call).to(eq included_post)
    end

    it 'returns posts filtered by branch, category and search' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new(
        { branch: 'hobby', search: 'test', category: 'arts' }
      ).call).to(eq included_post)
    end
  end
end
