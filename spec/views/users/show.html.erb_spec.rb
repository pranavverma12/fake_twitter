# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  context 'without validation errors' do
    let(:current_user) { create(:user) }
    let(:user1) {create(:user)}
    let(:session) { { user_id: current_user.id } }


    it 'displays User to which current_user is not following' do
      @current_user = current_user
      user = create(:user)
      assign(:user, user)

      render

      expect(rendered).to include 'User'

      expect(rendered).to include user.email
      expect(rendered).to include user.username
    end

    let(:post1) { create(:post, user_id: user1.id) }
    let(:relationship) { create(:relationship, follower_id: current_user.id, followed_id: user1.id) }

    it 'displays following User with its posts' do
      post1.reload
      relationship.reload
      allow(view).to receive_messages(:will_paginate => nil)

      @current_user = current_user
      assign(:user, user1)

      render
      
      expect(rendered).to include 'User'

      expect(rendered).to include user1.email
      expect(rendered).to include user1.username

      expect(rendered).to include 'Post'

      expect(rendered).to include user1.posts.first.description
      expect(rendered).to include user1.posts.first.photo
    end
  end
end
