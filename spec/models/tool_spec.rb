require 'rails_helper'

RSpec.describe Tool, type: :model do
  let!(:tool) { create(:tool) }
  let!(:tool_with_category) { create(:tool, :with_category) }
  let!(:user) { create(:user, :with_tool) }

  describe '.uncategorized' do
    let(:uncategorized) { Tool.uncategorized }
    let(:other_tool) { user.tools.first }
    it 'is all the tools without a category' do
      aggregate_failures do
        expect(uncategorized).to_not include(tool_with_category)
        expect(uncategorized).to contain_exactly(tool, other_tool)
      end
    end
  end

  describe '.not_in_category' do
    let(:category) { tool_with_category.category }
    let(:not_in_category) { Tool.not_in_category(category) }
    let(:other_tool) { user.tools.first }
    it 'is all the tool records not associated with a particular category' do
      aggregate_failures do
        expect(not_in_category).to_not include(tool_with_category)
        expect(not_in_category).to contain_exactly(tool, other_tool)
      end
    end
  end

  describe '.not_subscribed' do
    let(:not_subscribed) { Tool.not_subscribed(user) }
    let(:other_tool) { user.tools.first }
    it 'is all the tool records not associated with a particular user' do
      aggregate_failures do
        expect(not_subscribed).to_not include(other_tool)
        expect(not_subscribed).to contain_exactly(tool, tool_with_category)
      end
    end
  end

  describe '.user_counts' do
    let(:user_count) { Tool.user_counts }
    let(:tool_user) { user.tools.first }
    it 'counts the number of users that are associated with each tool record' do
      aggregate_failures do
        expect(user_count).to_not have_key(tool.id)
        expect(user_count).to eq({ tool_user.id => tool_user.users.count })
      end
    end
  end
end
