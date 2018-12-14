require "rails_helper"

RSpec.feature "Create new post", :type => :feature do
  let(:user) { create(:user) }
  before(:each) { sign_in user }

  shared_examples 'user creates new post' do |branch|
    scenario 'successful creation', js: true do
      create(:category, name: 'category', branch: branch)
      visit send("#{branch}_posts_path")
      find('.new-post-button').click
      expect(page).to have_css('.form-control')
      fill_in 'post[title]', with: 'a' * 20
      fill_in 'post[content]', with: 'a' * 20
      select 'category', from: 'post[category_id]'
      find('.create-post-button').click
      expect(page).to have_selector('#single-post-content')
    end

    scenario 'fails to save and renders new', js: true do
      create(:category, name: 'wrong_category', branch: branch)
      create(:category, name: 'wrong_branch_category', branch: 'wrong_branch')
      create(:category, name: 'category', branch: branch)
      visit send("#{branch}_posts_path")
      find('.new-post-button').click
      expect(page).to have_css('.form-control')
      fill_in 'post[title]', with: 'a'
      fill_in 'post[content]', with: 'a'
      select 'category', from: 'post[category_id]'
      find('.create-post-button').click
      expect(page).to have_selector('#error-explanation')
      # confirm form re-rendered with errors
      expect(find_field('post[title]').value).to eq 'a'
      expect(find_field('post[content]').value).to eq 'a'
      # confirm if fields remain pre-filled
      expect(page).to have_select('post[category_id]',
                                  selected: 'category',
                                  options: ['wrong_category', 'category'])
      # confirm only current branch categories were passed, and that selected
      # category istill pre-filled
    end
  end

  include_examples 'user creates new post', 'hobby'
  include_examples 'user creates new post', 'study'
  include_examples 'user creates new post', 'team'
end
