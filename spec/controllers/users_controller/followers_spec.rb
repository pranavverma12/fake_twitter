# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:current_user) { create(:user) }
  let(:valid_session) { { user_id: current_user.id } }
  let(:user1) {create(:user)}
  let(:relationship) { create(:relationship, follower_id: user1.id, followed_id: current_user.id) }
  let(:params) { {} }

  describe 'GET #followers' do
    subject { get :edit, params: params, session: valid_session }

    let!(:user) { create(:user) }
    let(:params) { { id: user.id } }

    it 'current_user being followed count' do
      relationship.reload
      user1.reload
      subject

      expect(current_user.followers.count).to eq 1
    end

    it 'responds with 200 OK' do
      subject
      expect(response).to have_http_status(:ok)
    end

    context 'when user is not logged in' do
      subject { get :edit, params: params, session: {} }

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
