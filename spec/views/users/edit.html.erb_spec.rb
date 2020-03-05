# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  context 'without validation errors' do
    let(:current_user) {create(:user)}

    it 'displays edit user form' do
      user = create(:user)

      assign(:user, user)

      render

      expect(rendered).to include 'Editing'

      expect(rendered).to match(
        have_css("form[action=\"/users/#{user.id}\"] input[name=\"user[username]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/users/#{user.id}\"] input[name=\"user[password]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/users/#{user.id}\"] input[name=\"user[email]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/users/#{user.id}\"] button[type=\"submit\"]")
      )

      expect(rendered).to_not match(/error/) # no errors on page
    end
  end

  context 'with validation errors' do
    let(:current_user) {create(:user)}
    
    it 'displays edit user form with error messages' do
      user = create(:user)
      user.username = nil
      user.validate

      assign(:user, user)

      render

      expect(rendered).to include 'Editing'

      expect(rendered).to match(
        have_css("form[action=\"/users/#{user.id}\"] input[name=\"user[username]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/users/#{user.id}\"] input[name=\"user[password]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/users/#{user.id}\"] input[name=\"user[email]\"]")
      )

      expect(rendered).to match(
        have_css("form[action=\"/users/#{user.id}\"] button[type=\"submit\"]")
      )

      expect(rendered).to match(/can&#39;t be blank/)
    end
  end
end
