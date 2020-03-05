# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:user1) { create(:user)}
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'POST #create' do
    subject { post :create, params: params, session: session }
    
    context 'when valid follwing attributes are passed' do
      let(:params) {{ followed_id: user1.id }}

      it 'assigns @user' do
        subject
        expect(assigns(:user)).to be_a User
      end

      it 'current_user follow other user' do
        expect { subject }.to change(Relationship, :count).by(1)
      end

      it 'responds with 302 Found' do
        subject
        expect(response).to have_http_status(:found)
      end

      it 'redirects to users#index' do
        subject
        expect(response).to redirect_to users_path
      end
    end

    context 'when invalid follwing attributes are passed' do
      let(:params) { { followed_id: nil } }

      it 'does not create a Relationship' do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when user is not logged in' do
      subject { post :create, params: params, session: {} }

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
