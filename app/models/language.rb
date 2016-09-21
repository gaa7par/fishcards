class Language < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 24 }
  validates :user_id, presence: true

  def random_flashcard
    flashcards.all[rand(flashcards.all.size)]
  end
end
