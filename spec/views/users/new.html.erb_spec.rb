# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  context 'without validation errors' do
    it 'displays new User form' do
      assign(:user, User.new)

      render

      expect(rendered).to include 'Register User'

      expect(rendered).to match(
        have_css('form[action="/users"] input[name="user[username]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/users"] input[name="user[password]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/users"] input[name="user[email]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/users"] button[type="submit"]')
      )

      expect(rendered).to_not match(/error/) # no errors on page
    end
  end

  context 'with validation errors' do
    it 'displays new Property form with error messages' do
      user = build(:user, username: nil)
      user.validate

      assign(:user, user)

      render

      expect(rendered).to include 'Register User'

      expect(rendered).to match(
        have_css('form[action="/users"] input[name="user[username]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/users"] input[name="user[password]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/users"] input[name="user[email]"]')
      )

      expect(rendered).to match(
        have_css('form[action="/users"] button[type="submit"]')
      )

      expect(rendered).to match(/can&#39;t be blank/)
    end
  end
end
