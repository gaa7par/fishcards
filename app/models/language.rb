class Language < ApplicationRecord
  has_many: flashcards, dependent: destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
end
