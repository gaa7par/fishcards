# frozen_string_literal: true
FactoryGirl.define do
  factory :flashcard do
    sequence(:front) { |n| "name-#{n}" }
    sequence(:back) { |n| "name-#{n}" }

    user_id { create(:user).id }
    language_id { create(:language).id }
  end
end
