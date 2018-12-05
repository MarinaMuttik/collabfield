require "rails_helper"

RSpec.feature "Visit single post", :type => :feature do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  scenario 'user navigates to a single post page', js: true do
    post
    visit root_path
    expect(page).to have_selector('.single-post-card')
    find('.single-post-card').click
    expect(page).to have_selector('#modalbox')
    find('.interested a').click
    expect(page).to have_selector('#single-post-content p', text: post.content)
  end
end
