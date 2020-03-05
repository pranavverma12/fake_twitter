# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/show', type: :view do
  let(:current_user) { create(:user) }

  it 'displays the Post' do
    @current_user = current_user
    post = create(:post, user_id: current_user.id)
    assign(:post, post)

    render
    
    expect(rendered).to include 'Post'
    expect(rendered).to include post.description
  end
end
