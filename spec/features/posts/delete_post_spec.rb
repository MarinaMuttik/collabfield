require "rails_helper"

RSpec.feature "Delete post", :type => :feature do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  before(:each) { sign_in user }

  scenario 'successful delete', js: true do
    post
    visit post_path(post)
    find('.btn', text: 'Delete post').click
    a = page.driver.browser.switch_to.alert
    expect(a.text).to eq("Are you sure?")
    a.accept
    expect(page).to have_selector('p', text: 'Your post was successfully deleted.')
  end

  scenario 'failed delete', js: true do
    post
    visit post_path(post)
    find('.btn', text: 'Delete post').click
    a = page.driver.browser.switch_to.alert
    expect(a.text).to eq("Are you sure?")
    a.dismiss
    expect(page).to have_selector('p', text: post.content)
  end

end
