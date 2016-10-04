class Flashcard < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :front, presence: true, uniqueness: true
  validates :back, presence: true
  validates :user_id, :language_id, presence: true

  paginates_per 10

  ratyrate_rateable 'stars'

  def the_same?(params)
    self.back.downcase == params[:back].downcase
  end
end
