class Language < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :user_id, presence: true

  def quiz(number = 5)
    flashcards.all.shuffle[0..number - 1]
  end
end
