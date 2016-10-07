# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#ban' do
    let(:user) { create(:user, banned: false) }
    let(:call_request) { patch :ban, params: { id: user.id } }

    context 'after request' do
      it { expect { call_request }.to change { user.reload.banned }.from(false).to(true) }
    end
  end

  describe '#unban' do
    let(:user) { create(:user, banned: true) }
    let(:call_request) { patch :unban, params: { id: user.id } }

    context 'after request' do
      it { expect { call_request }.to change { user.reload.banned }.from(true).to(false) }
    end
  end
end
