require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  it 'has valid factory' do
    expect(build(:flashcard)).to be_valid
  end
end
