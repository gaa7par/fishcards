require 'rails_helper'

RSpec.describe User::LanguagesController, type: :controller do
  let(:user) { create(:user, admin: true) }
  before { sign_in user }

  describe '#index' do
    let(:call_request) { get :index }

    context 'after request' do
      before { call_request }

      it { should render_template 'index' }
    end
  end

  describe '#show' do
    let(:call_request) { get :show, id: language.id }
    let!(:language) { create(:language, user_id: user.id) }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:language)).to eq language }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:language).persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: language.id }
    let!(:language) { create(:language, user_id: user.id) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:language)).to eq language }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, language: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:language, name: 'Spanish', user_id: user.id) }

      it { expect { call_request }.to change { Language.count }.by(1) }

      context 'after request' do
        before { call_request }

        let(:language) { Language.last }

        it { should redirect_to user_language_path(language) }
        it { expect(language.name).to eq 'Spanish' }
      end

      context 'invalid request' do
        let(:attributes) { attributes_for(:language, name: nil, user_id: nil) }

        it { expect { call_request }.not_to change { Language.count } }

        context 'after request' do
          before { call_request }

          it { should render_template 'new' }
        end
      end
    end
  end

  describe '#update' do
    let(:language) { create(:language, name: 'Spanish', user_id: user.id) }
    let(:call_request) { put :update, language: attributes, id: language.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:language, name: 'French', user_id: user.id) }

      it { expect { call_request }.to change { language.reload.name }.from('Spanish').to('French') }

      context 'after request' do
        before { call_request }

        it { should redirect_to user_language_path(language) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:language, name: nil, user_id: user.id) }

      it { expect { call_request }.not_to change { language.reload.name } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: language.id }
    let!(:language) { create(:language, user_id: user.id) }

    it { expect { call_request }.to change { Language.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to user_languages_path }
    end
  end
end
