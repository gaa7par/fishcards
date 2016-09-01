require 'rails_helper'

RSpec.describe User::FlashcardsController, type: :controller do
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
    let(:call_request) { get :show, id: flashcard.id }
    let!(:flashcard) { create(:flashcard) }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:flashcard)).to eq flashcard }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:flashcard).persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: flashcard.id }
    let!(:flashcard) { create(:flashcard) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:flashcard)).to eq flashcard }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, flashcard: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:flashcard, front: 'el chico', back: 'the boy') }

      it { expect { call_request }.to change { Flashcard.count }.by(1) }

      context 'after request' do
        before { call_request }

        let(:flashcard) { Flashcard.last }

        it { should redirect_to user_language_flashcard_path(flashcard) }
        it { expect(flashcard.front).to eq 'el chico' }
        it { expect(flashcard.back).to eq 'the boy' }
      end

      context 'invalid request' do
        let(:attributes) { attributes_for(:flashcard, front: nil, back: nil) }

        it { expect { call_request }.not_to change { Flashcard.count } }

        context 'after request' do
          before { call_request }

          it { should render_template 'new' }
        end
      end
    end
  end

  describe '#update' do
    let(:flashcard) { create(:flashcard, front: 'el chico', back: 'the boy') }
    let(:call_request) { put :update, flashcard: attributes, id: flashcard.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:flashcard, front: 'la chica', back: 'the girl') }

      it { expect { call_request }.to change { flashcard.reload.front }.from('el chico').to('the boy') }
      it { expect { call_request }.to change { flashcard.reload.back }.from('la chica').to('the girl') }

      context 'after request' do
        before { call_request }

        it { should redirect_to user_language_flashcard_path(flashcard) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:flashcard, front: nil, back: nil) }

      it { expect { call_request }.not_to change { flashcard.reload.front } }
      it { expect { call_request }.not_to change { flashcard.reload.back } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: flashcard.id }
    let!(:flashcard) { create(:flashcard) }

    it { expect { call_request }.to change { Flashcard.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to user_flashcards_path }
    end
  end
end
