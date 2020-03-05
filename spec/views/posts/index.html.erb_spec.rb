# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  let(:current_user) { create(:user) }
  context 'User present' do
 
    it 'displays all Posts' do
      allow(view).to receive_messages(:will_paginate => nil)

      @current_user = current_user
      posts = create_list(:post, 2, user_id: current_user.id)
      assign(:posts, posts)

      render

      expect(rendered).to include 'Posts'

      posts.each do |post|
        expect(rendered).to include post.description
        expect(rendered).to include post&.photo
      end
    end
  end
end
