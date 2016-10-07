# frozen_string_literal: true
class Rate < ApplicationRecord
  belongs_to :rater, class_name: 'User'
  belongs_to :rateable, polymorphic: true

  # attr_accessible :rate, :dimension

  paginates_per 10
end
