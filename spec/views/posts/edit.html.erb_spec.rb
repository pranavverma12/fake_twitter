# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/edit', type: :view do
  let(:user) { create(:user) }

  context 'without validation errors' do
    it 'displays edit Post form' do
      post = create(:post, user_id: user.id)
      assign(:post, post)

      render

      expect(rendered).to include 'Edit'

      expect(rendered).to match(
        have_css("form[action=\"/posts/#{post.id}\"] textarea[name=\"post[description]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/posts/#{post.id}\"] input[name=\"post[photo]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/posts/#{post.id}\"] button[type=\"submit\"]")
      )      
    end
  end

  context 'with validation errors' do
    it 'displays edit Post form with error messages' do
      post = create(:post, user_id: user.id)
      post.description = nil
      post.validate

      assign(:post, post)

      render

      expect(rendered).to include 'Edit'

      expect(rendered).to match(
        have_css("form[action=\"/posts/#{post.id}\"] textarea[name=\"post[description]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/posts/#{post.id}\"] input[name=\"post[photo]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/posts/#{post.id}\"] button[type=\"submit\"]")
      )

      expect(rendered).to match(/can&#39;t be blank/)
    end
  end
end
