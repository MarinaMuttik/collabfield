require 'rails_helper'

RSpec.feature 'Contact User', :type => :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category, name: 'Arts', branch: 'hobby') }
  let(:post) { create(:post, category_id: category.id) }

  context 'logged in user' do
    before(:each) { sign_in user }

    scenario 'successfuly sends message to posts user', js: true do
      visit post_path(post)
      expect(page).to have_selector('.contact-user form')

      fill_in('message_body', with: 'a' * 20)
      find('form .send-message').click

      expect(page).not_to have_selector('.contact-user form')
      expect(page).to have_selector('.contacted-user',
                                    text: 'Message has been sent')
    end

    scenario 'sees already contacted message' do
      create(:private_conversation_with_messages,
             recipient_id: post.user.id,
             sender_id: user.id)
      visit post_path(post)
      expect(page).to have_selector(
        '.contact-user .contacted-user',
        text: 'You are already in touch with this user')
    end
  end

  context 'non-logged-in user' do
    scenario 'sees a login require message to contact' do
      visit post_path(post)
      expect(page).to have_selector('.text-center',
                                    text: 'To contact the user you have to')
    end
  end
end
