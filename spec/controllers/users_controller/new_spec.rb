# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:current_user) { create(:user) }
  let(:valid_session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'GET #new' do
    subject { get :new, params: params, session: valid_session }

    let(:params) { {} }

    it 'assigns @user' do
      subject
      expect(assigns(:user)).to be_a User
    end

    it 'responds with 200 OK' do
      subject
      expect(response).to have_http_status(:ok)
    end
  end
end
