FactoryGirl.define do
  factory :flashcard do
    sequence(:front) { |n| "name-#{n}" }
    sequence(:back) { |n| "name-#{n}" }

    user_id 1
    language_id 1
  end
end
