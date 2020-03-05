# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:current_user) { create(:user) }
  let(:session) { { user_id: current_user.id } }
  let(:my_posts) { create_list(:post, 2, user_id: current_user.id) }

  describe 'GET #feeds' do
    subject { get :feeds, session: session }

    context 'when user is logged in and not following any user' do
      it 'assigns @posts' do
        subject
        expect(assigns(:posts)).to match_array my_posts
      end

      it 'redirects to posts#feeds' do      
        subject
        expect(response).to have_http_status(:ok)
      end

      it 'display current_user posts only' do
        my_posts
        subject

        expect(assigns(:posts).count).to eq 2
      end
    end

    context 'when user is logged in and following a user having post' do
      let(:user1) { create(:user) }
      let(:post1) { create(:post, user_id: user1.id) }
      let(:relationship) { create(:relationship, follower_id: current_user.id, followed_id: user1.id) }

      it 'assigns @posts' do
        my_posts
        relationship.reload
        post1.reload 
        subject

        expect(assigns(:posts)).to match_array (my_posts + [post1])
      end

      it 'redirects to posts#feeds' do    
        subject        
        expect(response).to have_http_status(:ok)
      end

      it 'display all posts' do
        my_posts
        relationship.reload
        post1.reload
        subject

        expect(assigns(:posts).count).to eq 3
      end
    end

    context 'when user is not logged in' do
      subject { get :feeds, session: {} }

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
