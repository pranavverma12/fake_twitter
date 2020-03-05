# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/new', type: :view do
  context 'without validation errors' do
    it 'displays new Post form' do
      assign(:post, Post.new)

      render

      expect(rendered).to include 'New Post'

      expect(rendered).to match have_css 'form[action="/posts"] textarea[name="post[description]"]'
      expect(rendered).to match have_css 'form[action="/posts"] input[name="post[photo]"]'
      expect(rendered).to match have_css 'form[action="/posts"] button[type="submit"]'

    end
  end

  context 'with validation errors' do
    it 'displays new Post form with error messages' do
      post = build(:post, description: nil)
      post.validate

      assign(:post, post)

      render

      expect(rendered).to include 'New Post'

      expect(rendered).to match have_css 'form[action="/posts"] textarea[name="post[description]"]'
      expect(rendered).to match have_css 'form[action="/posts"] input[name="post[photo]"]'
      expect(rendered).to match have_css 'form[action="/posts"] button[type="submit"]'

      expect(rendered).to match(/can&#39;t be blank/)
    end
  end
end
