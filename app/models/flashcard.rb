class Flashcard < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :front, presence: true, uniqueness: true
  validates :back, presence: true
  validates :user_id, :language_id, presence: true

  paginates_per 25
end
