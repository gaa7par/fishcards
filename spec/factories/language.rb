FactoryGirl.define do
  factory :language do
    sequence(:name) { |n| "name-#{n}" }
  end
end
