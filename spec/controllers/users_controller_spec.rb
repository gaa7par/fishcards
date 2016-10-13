# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }

  describe '#index' do
    let(:call_request) { get :index }

    context 'after request' do
      before { call_request }

      it { should render_template 'index' }
    end
  end

  describe '#show' do
    let(:call_request) { get :show, params: { id: user.id } }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:user)).to eq user }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, params: { id: user.id } }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:user)).to eq user }
    end
  end

  describe '#ban' do
    let(:call_request) { patch :ban, params: { id: user.id } }

    context 'after request' do
      it { expect { call_request }.to change { user.reload.banned }.from(false).to(true) }
    end
  end

  describe '#unban' do
    let(:call_request) { patch :unban, params: { id: banned_user.id } }
    let!(:banned_user) { create(:user, banned: true) }

    context 'after request' do
      it { expect { call_request }.to change { banned_user.reload.banned }.from(true).to(false) }
    end
  end
end
