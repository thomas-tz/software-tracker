require 'rails_helper'

RSpec.describe User do
  let!(:user) { create(:user) }
  let!(:tool) { create(:tool, :with_user) }

  describe '#name' do
    it 'is the user\'s first and last name' do
      expect(user.name).to eq "#{user.first_name} #{user.last_name}"
    end
  end

  describe '.not_subscribed' do
    it 'is all the user records not associated with a particular tool' do
      expect(described_class.not_subscribed(tool)).to contain_exactly(user)
    end
  end

  describe '.tool_counts' do
    let(:tool_count) { described_class.tool_counts }
    let(:tool_user) { tool.users.first }
    it 'counts the number of tools that are associated with each user record' do
      expect(tool_count).to eq({ tool_user.id => tool_user.tools.count})
    end
  end
end