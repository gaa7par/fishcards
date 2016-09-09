class Language < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :user_id, presence: true
end
