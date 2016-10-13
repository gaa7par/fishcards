FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "name#{n}" }
    sequence(:email) { |n| "email-#{n}@example.com" }
    password 'secret'
    password_confirmation 'secret'

    admin false
    banned false

    after(:build, &:confirm)
  end
end
