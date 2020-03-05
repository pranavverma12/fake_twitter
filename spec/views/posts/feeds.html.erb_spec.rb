# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/feeds', type: :view do
  let(:current_user) { create(:user) }
  let!(:post1) { create(:post, user_id: current_user.id) }
  let!(:post2) { create(:post, user_id: current_user.id) }

  it 'displays all Properties which are rented' do
    allow(view).to receive_messages(:will_paginate => nil)
    
    posts = [post1, post2]
    @current_user = current_user

    assign(:posts, posts)

    render

    expect(rendered).to include 'Feeds'

    posts.each do |post|
      expect(rendered).to include post.description
      expect(rendered).to include post.photo
    end
  end
end
