FactoryGirl.define do
  factory :language do
    sequence(:name) { |n| "name-#{n}" }
    user_id 1
  end
end
