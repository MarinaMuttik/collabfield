require 'rails_helper'

RSpec.feature "Infinite Scroll", :type => :feature do
  Post.per_page = 15

  let(:check_posts_count) do
    expect(page).to have_selector('.single-post-list', count: 15)
    page.execute_script("$(window).scrollTop($(document).height())")
    expect(page).to have_selector('.single-post-list', count: 30)
  end

  scenario 'scroll hobby page and posts list
           appends with older posts', js: true do
    create_list(:post, 30, category: create(:category, branch: 'hobby'))
    visit hobby_posts_path
    check_posts_count
  end

  scenario 'scroll study page and posts list
           appends with older posts', js: true do
    create_list(:post, 30, category: create(:category, branch: 'study'))
    visit study_posts_path
    check_posts_count
  end

  scenario 'scroll team page and posts list
           appends with older posts', js: true do
    create_list(:post, 30, category: create(:category, branch: 'team'))
    visit team_posts_path
    check_posts_count
  end
end
