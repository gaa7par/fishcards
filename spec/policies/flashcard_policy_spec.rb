require 'rails_helper'

RSpec.describe FlashcardPolicy do

  let(:user) { User.new }

  subject { described_class }

  permissions :edit?, :update?, :destroy? do
    it "grants access if flashcard is created by current user" do
      expect(subject).to permit(user, user.flashcards.new)
    end

    it "denies access if flashcard is not created by current user" do
      expect(subject).not_to permit(user, Flashcard.new)
    end

    it "grants access if user is an admin" do
      expect(subject).to permit(User.new(admin: true), Flashcard.new)
    end

    it "denies access if user is not an admin" do
      expect(subject).not_to permit(User.new(admin: false), Flashcard.new)
    end
  end
end
