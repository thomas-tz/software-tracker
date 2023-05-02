require 'rails_helper'

RSpec.describe CategoryToolsController, type: :request do
  let(:tool) { create(:tool) }
  let(:category) { create(:category) }
  let(:tool_with_category) { create(:tool, :with_category) }

  describe 'POST /create' do
    it 'updates the requested tool with the category associationT' do
      post category_tools_path, params: { id: tool.to_param, category_id: category.to_param }, headers: {
        referer: root_path
      }
      tool.reload
      expect(tool.category).to eq(category)
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested tool\'s category association' do
      delete category_tool_path(tool_with_category), headers: { referer: root_path }
      tool_with_category.reload
      expect(tool_with_category.category).to be_nil
    end
  end
end
