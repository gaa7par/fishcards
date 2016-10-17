require 'rails_helper'

RSpec.describe Language, type: :model do
  it 'has valid factory' do
    expect(build(:language)).to be_valid
  end

  describe '#random_flashcard' do
    let(:language) { create(:language) }
    let(:flashcard1) { create(:flashcard, id: 1, language_id: language.id) }
    let(:flashcard2) { create(:flashcard, id: 2, language_id: language.id) }
    let(:flashcard3) { create(:flashcard, id: 3, language_id: language.id) }

    context 'should return random flashcard' do
      let(:flashcards) { [flashcard1, flashcard2, flashcard3] }

      it { expect(flashcards).to include language.random_flashcard }
    end
  end
end
