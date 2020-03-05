# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:params) { {} }

  describe 'PUT #update' do
    subject { put :update, params: params, session: session }

    let!(:post) { create(:post, user_id: current_user.id) }
    let(:params) { { id: post.id } }

    context 'when valid post param attributes' do
      let(:valid_post_attributes) do
        {
          description: 'some post description fro testing',
          user_id: current_user.id
        }
      end
      let(:params) { { id: post.id, post: valid_post_attributes } }

      it 'assigns @post' do
        subject
        expect(assigns(:post)).to be_a Post
      end

      it 'updates the Post' do
        subject
        post.reload

        expect(post.description).to eq valid_post_attributes[:description]
        expect(post.user_id).to eq valid_post_attributes[:user_id]
      end

      it 'responds with 302 Found' do
        subject
        expect(response).to have_http_status(:found)
      end

      it 'redirects to post#show' do
        subject
        expect(response).to redirect_to Post.last
      end
    end

    context 'when invalid post param attributes' do
      let(:invalid_post_attributes) do
        {
          description: '',
          user_id: ''
        }
      end
      let(:params) { { id: post.id, post: invalid_post_attributes } }

      it 'does not update the post' do
        expect { subject }.to_not(change { post.reload.attributes })
      end

      it 'responds with unprocessable_entity' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is not logged in' do
      subject { put :update, params: params, session: {} }

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
