# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'GET #index' do
    subject { get :index, params: params, session: session }

    let!(:post1) { create(:post, user_id: current_user.id) }
    let!(:post2) { create(:post, user_id: current_user.id) }

    it 'assigns @posts' do
      subject
      expect(assigns(:posts)).to match_array [post1, post2]
    end

    it 'responds with 200 OK' do
      subject
      expect(response).to have_http_status(:ok)
    end

    context 'when user is not logged in' do
      subject { get :index, params: params, session: {} }

      it 'returns http forbidden status' do
        subject
        expect(response).to have_http_status(:forbidden)
      end

      it 'renders error page' do
        subject
        expect(response).to render_template('errors/not_authorized')
      end
    end
  end
end
