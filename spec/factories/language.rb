FactoryGirl.define do
  factory :language do
    sequence(:name) { |n| "name-#{n}" }

    user_id { create(:user).id }
  end
end
