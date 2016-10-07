# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  it 'has valid factory' do
    expect(build(:flashcard)).to be_valid
  end

  describe '#the_same?' do
    let(:flashcard) { create(:flashcard, front: 'el chico', back: 'the boy') }

    context 'correct answer' do
      let(:params) { { back: 'the boy' } }

      it { expect(flashcard.the_same?(params)).to eq true }
    end

    context 'incorrect answer' do
      let(:params) { { back: 'the girl' } }

      it { expect(flashcard.the_same?(params)).to eq false }
    end
  end
end
