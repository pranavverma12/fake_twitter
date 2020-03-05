# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  context 'Logged in user' do
    let(:current_user) { create(:user) }
    let(:session) { { user_id: current_user.id } }

    it 'renders a list of users' do
      allow(view).to receive_messages(:will_paginate => nil)

      @current_user = current_user
      users = create_list(:user, 2)
      assign(:users, users)

      render

      expect(rendered).to include 'Users'

      users.each do |user|
        expect(rendered).to include user.email
        expect(rendered).to include user.username
        expect(rendered).to include 'Actions'
      end
    end
  end
end
