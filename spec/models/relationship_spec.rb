# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'presence of' do
    it 'follower_id' do
      expect(
        build(:relationship, follower_id: nil).errors_on(:follower_id)
      ).to eq [I18n.t('errors.messages.blank')]
    end

    it 'followed_id' do
      expect(
        build(:relationship, followed_id: nil).errors_on(:followed_id)
      ).to eq [I18n.t('errors.messages.blank')]
    end
  end
end
