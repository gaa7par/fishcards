require 'rails_helper'

RSpec.describe User::FlashcardsController, type: :controller do
  let(:user) { create(:user, admin: true) }
  let(:language) { create(:language, user_id: user.id) }
  before { sign_in user }

  describe '#show' do
    let(:call_request) { get :show, id: flashcard.id, language_id: language.id }
    let!(:flashcard) { create(:flashcard, user_id: user.id, language_id: language.id) }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:flashcard)).to eq flashcard }
    end
  end

  describe '#new' do
    let(:call_request) { get :new, language_id: language.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:flashcard).persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: flashcard.id, language_id: language.id }
    let!(:flashcard) { create(:flashcard, user_id: user.id, language_id: language.id) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:flashcard)).to eq flashcard }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, flashcard: attributes, language_id: language.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:flashcard, front: 'el chico', back: 'the boy', user_id: user.id, language_id: language.id) }

      it { expect { call_request }.to change { Flashcard.count }.by(1) }

      context 'after request' do
        before { call_request }

        let(:flashcard) { Flashcard.last }

        it { should redirect_to user_language_flashcard_path(language.id, flashcard) }
        it { expect(flashcard.front).to eq 'el chico' }
        it { expect(flashcard.back).to eq 'the boy' }
      end

      context 'invalid request' do
        let(:attributes) { attributes_for(:flashcard, front: nil, back: nil, user_id: nil, language_id: nil) }

        it { expect { call_request }.not_to change { Flashcard.count } }

        context 'after request' do
          before { call_request }

          it { should render_template 'new' }
        end
      end
    end
  end

  describe '#update' do
    let(:flashcard) { create(:flashcard, front: 'el chico', back: 'the boy', user_id: user.id, language_id: language.id) }
    let(:call_request) { put :update, flashcard: attributes, id: flashcard.id, language_id: language.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:flashcard, front: 'la chica', back: 'the girl', user_id: user.id, language_id: language.id) }

      it { expect { call_request }.to change { flashcard.reload.front }.from('el chico').to('la chica') }
      it { expect { call_request }.to change { flashcard.reload.back }.from('the boy').to('the girl') }

      context 'after request' do
        before { call_request }

        it { should redirect_to user_language_flashcard_path(language.id, flashcard) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:flashcard, front: nil, back: nil, user_id: user.id, language_id: language.id) }

      it { expect { call_request }.not_to change { flashcard.reload.front } }
      it { expect { call_request }.not_to change { flashcard.reload.back } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: flashcard.id, language_id: language.id }
    let!(:flashcard) { create(:flashcard, user_id: user.id, language_id: language.id) }

    it { expect { call_request }.to change { Flashcard.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to user_language_path(language) }
    end
  end

  describe '#check_answer' do
    let(:call_request) { xhr :get, :check_answer, id: flashcard.id, back: back }
    let!(:flashcard) { create(:flashcard, front: 'el chico', back: 'the boy', user_id: user.id, language_id: language.id) }

    context 'correct answer' do
      let(:back) { 'the boy' }
      it { expect { call_request }.to change { user.points }.by(1) }

      context 'after request' do
        before { call_request }

        it { should render :check_answer }
      end
    end

    context 'incorrect answer' do
      let(:back) { 'the girl' }
      it { expect { call_request }.not_to change { user.points } }

      context 'after request' do
        before { call_request }

        it { should render :correct }
      end
    end
  end
end
