require 'rails_helper'

RSpec.describe User do
  let!(:tool) { create(:tool, :with_user) }
  let!(:user) { create(:user) }

  describe '#name' do
    it 'is the user\'s first and last name' do
      expect(user.name).to eq "#{user.first_name} #{user.last_name}"
    end
  end

  describe '.not_subscribed' do
    it 'is all the user records not associated with a particular tool' do
      aggregate_failures do
        expect(User.not_subscribed(tool)).to contain_exactly(user)
        expect(User.not_subscribed(tool)).to_not include(tool.users.first)
      end
    end
  end

  describe '.tool_counts' do
    let(:tool_count) { User.tool_counts }
    let(:tool_user) { tool.users.first }
    it 'counts the number of tools that are associated with each user record' do
      aggregate_failures do
        expect(tool_count).to_not have_key(user.id)
        expect(tool_count).to eq({ tool_user.id => tool_user.tools.count})
      end
    end
  end
end