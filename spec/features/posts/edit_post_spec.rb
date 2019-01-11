require "rails_helper"

RSpec.feature "Edit post", :type => :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category, name: 'category', branch: 'hobby') }
  let(:post) { create(:post, title: 'a' * 20, content: 'a' * 20, category_id: category.id, user: user) }
  before(:each) { sign_in user }

  scenario 'successful edit', js: true do
    category
    post
    visit post_path(post)
    find('.btn', text: 'Edit post').click
    expect(page).to have_css('.form-control')
    fill_in 'post[title]', with: 'b' * 20
    fill_in 'post[content]', with: 'b' * 20
    find('.create-post-button').click
    expect(page).to have_selector('#single-post-content p', text: 'b' * 20)
  end

  scenario 'fails to save and renders edit', js: true do
    create(:category, name: 'wrong_category', branch: 'hobby')
    create(:category, name: 'wrong_branch_category', branch: 'wrong_branch')
    category
    post
    visit post_path(post)
    find('.btn', text: 'Edit post').click
    expect(page).to have_css('.form-control')
    fill_in 'post[title]', with: 'b'
    fill_in 'post[content]', with: 'b'
    find('.create-post-button').click
    expect(page).to have_selector('#error-explanation')
    # confirm form re-rendered with errors
    expect(find_field('post[title]').value).to eq 'b'
    expect(find_field('post[content]').value).to eq 'b'
    # confirm if fields remain pre-filled
    expect(page).to have_select('post[category_id]',
                                selected: 'category',
                                options: ['wrong_category', 'category'])
    # confirm only current branch is applied
  end
end
