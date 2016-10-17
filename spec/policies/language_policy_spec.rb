require 'rails_helper'

RSpec.describe LanguagePolicy do
  subject { described_class }

  permissions :edit?, :create?, :update?, :destroy? do
    let(:user) { create(:user, admin: false) }
    let(:admin) { create(:user, admin: true) }

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin)
    end

    it 'denies access if user is not an admin' do
      expect(subject).not_to permit(user)
    end
  end
end
