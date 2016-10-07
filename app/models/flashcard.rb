# frozen_string_literal: true
class Flashcard < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :front, presence: true, uniqueness: true
  validates :back, presence: true
  validates :user_id, :language_id, presence: true

  ratyrate_rateable 'stars'

  def the_same?(params)
    back.casecmp(params[:back]).zero?
  end
end
