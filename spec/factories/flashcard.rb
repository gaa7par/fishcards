FactoryGirl.define do
  factory :flashcard do
    sequence(:front) { |n| "name-#{n}" }
    sequence(:back) { |n| "name-#{n}" }
  end
end
