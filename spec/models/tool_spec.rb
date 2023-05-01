require 'rails_helper'

RSpec.describe Tool, type: :model do
  let!(:tool) { create(:tool, :with_user) }
  let!(:tool_with_category) { create(:tool, :with_category) }

  describe '.uncategorized' do
    let(:uncategorized) { described_class.uncategorized }
    it 'is all the tools without a category' do
      expect(uncategorized).to contain_exactly(tool)
    end
  end

  describe '.not_in_category' do
    let(:category) { tool_with_category.category }
    let(:not_in_category) { described_class.not_in_category(category) }
    it 'is all the tool records not associated with a particular category' do
      expect(not_in_category).to contain_exactly(tool)
    end
  end

  describe '.not_subscribed' do
    let(:user) { tool.users.first }
    let(:not_subscribed) { described_class.not_subscribed(user) }
    it 'is all the tool records not associated with a particular user' do
      expect(not_subscribed).to contain_exactly(tool_with_category)
    end
  end

  describe '.user_counts' do
    let(:user_count) { described_class.user_counts }
    it 'counts the number of users that are associated with each tool record' do
      expect(user_count).to eq({ tool.id => tool.users.count })
    end
  end
end
