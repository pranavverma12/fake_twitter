# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  describe 'presence of' do
    it 'description' do
      expect(
        build(:post, description: nil).errors_on(:description)
      ).to eq [I18n.t('errors.messages.blank')]
    end

    it 'user_id' do
      expect(
        build(:post, user_id: nil).errors_on(:user_id)
      ).to eq [I18n.t('errors.messages.blank')]
    end
  end

  describe 'length of' do
    it 'description having min of Post::DESCRIPTION_MIN_LENGTH' do
      expect(
        build(:post, description: 'a' * (Post::DESCRIPTION_MIN_LENGTH - 1), user_id: user.id).errors_on(:description)
      ).to eq [I18n.t(
        'errors.messages.too_short',
        count: Post::DESCRIPTION_MIN_LENGTH
      )]

      expect(
        build(:post, description: 'a' * Post::DESCRIPTION_MIN_LENGTH, user_id: user.id)
      ).to be_valid
    end
  end
end
