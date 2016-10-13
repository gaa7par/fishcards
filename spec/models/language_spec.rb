require 'rails_helper'

RSpec.describe Language, type: :model do
  it 'has valid factory' do
    expect(build(:language)).to be_valid
  end
end
