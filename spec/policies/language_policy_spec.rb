require 'rails_helper'

RSpec.describe LanguagePolicy do

  subject { described_class }

  permissions :edit?, :create?, :update?, :destroy? do
    it "grants access if user is an admin" do
      expect(subject).to permit(User.new(admin: true))
    end

    it "denies access if user is not an admin" do
      expect(subject).not_to permit(User.new(admin: false))
    end
  end
end
