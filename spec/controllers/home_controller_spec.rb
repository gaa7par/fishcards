require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  describe '#show' do
    let(:call_request) { get :show }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
    end
  end
end
