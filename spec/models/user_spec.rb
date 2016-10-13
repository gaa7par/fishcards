require 'rails_helper'

RSpec.describe User do
  it 'has valid factory' do
    expect(build(:user)).to be_valid
  end
end
