require 'rails_helper'

RSpec.describe PostsHelper, :type => :helper do
  context '#create_new_post_partial_path' do
    it "returns a signed_in partials path" do
      allow(helper).to receive(:user_signed_in?).and_return(true)
      expect(helper.create_new_post_partial_path).to (
        eq 'posts/branch/create_new_post/signed_in'
      )
    end
    it "returns a not_signed_in partials path" do
      allow(helper).to receive(:user_signed_in?).and_return(false)
      expect(helper.create_new_post_partial_path).to (
        eq 'posts/branch/create_new_post/not_signed_in'
      )
    end
  end

  context '#all_categories_button_partial_path' do
    it 'returns an all_selected partials path' do
      controller.params[:category] = ''
      expect(helper.all_categories_button_partial_path).to (
        eq 'posts/branch/categories/all_selected'
      )
    end
    it 'returns an all_not_selected partials path' do
      controller.params[:category] = 'category'
      expect(helper.all_categories_button_partial_path).to (
        eq 'posts/branch/categories/all_not_selected'
      )
    end
  end

  context '#no_posts_partial_path' do
    it 'returns a no_posts partials path' do
      posts = []
      expect(helper.no_posts_partial_path(posts)).to (
        eq 'shared/no_posts'
      )
    end
    it 'returns an empty partials path' do
      posts = [1]
      expect(helper.no_posts_partial_path(posts)).to (
        eq 'shared/empty_partial'
      )
    end
  end

  context '#post_format_partial_path' do
    it 'returns a home_page partials path' do
      allow(helper).to receive(:current_page?).and_return(true)
      expect(helper.post_format_partial_path).to (
        eq 'posts/post/home_page'
      )
    end
    it 'returns a branch_page partials path' do
      allow(helper).to receive(:current_page?).and_return(false)
      expect(helper.post_format_partial_path).to (
        eq 'posts/post/branch_page'
      )
    end
  end

  context '#category_field_partial_path' do
    it 'returns a category_form partial path' do
      controller.params[:category] = 'category'
      expect(helper.category_field_partial_path).to (
        eq 'posts/branch/search_form/category_form'
      )
    end
    it 'returns an empty partials path' do
      controller.params[:category] = nil
      expect(helper.category_field_partial_path).to (
        eq 'shared/empty_partial'
      )
    end
  end

  context '#update_pagination_partial_path' do
    it 'returns an update_pagination partial path' do
      posts = double('posts', :next_page => 2)
      assign(:posts, posts)
      expect(helper.update_pagination_partial_path).to (
        eq 'posts/posts_pagination_page/update_pagination'
      )
    end
    it 'returns a remove_pagination partial path' do
      posts = double('posts', :next_page => nil)
      assign(:posts, posts)
      expect(helper.update_pagination_partial_path).to (
        eq 'posts/posts_pagination_page/remove_pagination'
      )
    end
  end

  context '#contact_user_partial_path' do
    before(:each) do
      @current_user = create(:user, id: 1)
      allow(helper).to receive(:current_user).and_return(@current_user)
    end

    it 'returns a contact_user_partial_path' do
      allow(helper).to receive(:user_signed_in?).and_return(true)
      assign(:post, create(:post, user_id: create(:user, id: 2).id))
      expect(helper.contact_user_partial_path).to(
        eq 'posts/show/contact_user'
      )
    end

    it 'returns a empty partials path' do
      allow(helper).to receive(:user_signed_in?).and_return(true)
      assign(:post, create(:post, user_id: @current_user.id))
      expect(helper.contact_user_partial_path).to(
        eq 'shared/empty_partial'
      )
    end

    it 'returns a login_required path' do
      allow(helper).to receive(:user_signed_in?).and_return(false)
      expect(helper.contact_user_partial_path).to(
        eq 'posts/show/login_required'
      )
    end
  end

  context '#leave_message_partial_path' do
    it 'returns an already_in_touch partials path' do
      assign('message_has_been_sent', true)
      expect(helper.leave_message_partial_path).to(
        eq 'posts/show/contact_user/already_in_touch'
      )
    end

    it 'returns a message_form partials path' do
      assign('message_has_been_sent', false)
      expect(helper.leave_message_partial_path).to(
        eq 'posts/show/contact_user/message_form'
      )
    end
  end
end
