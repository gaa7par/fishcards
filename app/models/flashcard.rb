class Flashcard < ApplicationRecord
  belongs_to :language
  validates :front, presence: true, uniqueness: true
  validates :back, presence: true
end
