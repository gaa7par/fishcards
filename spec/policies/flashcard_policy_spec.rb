require 'rails_helper'

RSpec.describe FlashcardPolicy do
  subject { described_class }

  permissions :edit?, :update?, :destroy? do
    let(:user) { create(:user, admin: false) }
    let(:admin) { create(:user, admin: true) }
    let(:flashcard) { create(:flashcard) }

    it 'grants access if flashcard is created by current user' do
      expect(subject).to permit(user, user.flashcards.new)
    end

    it 'denies access if flashcard is not created by current user' do
      expect(subject).not_to permit(user, flashcard)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin, flashcard)
    end

    it 'denies access if user is not an admin' do
      expect(subject).not_to permit(user, flashcard)
    end
  end
end
