FactoryGirl.define do
  factory :private_message, class: 'Private::Message' do
    association :conversation, factory: :private_conversation

    body 'a' * 20
    user
  end
end
