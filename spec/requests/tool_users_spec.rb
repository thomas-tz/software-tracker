require 'rails_helper'

RSpec.describe ToolUsersController, type: :request do
  let(:tool) { create(:tool) }
  let(:user) { create(:user) }
  let!(:tool_user) { create(:tool_user) }
  let(:invalid_attributes) { { tool_id: '', user_id: '' } }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new ToolUser association' do
        expect {
          post tool_users_path, params: { tool_user: { user_id: user.to_param, tool_id: tool.to_param } }, headers: {
            referer: root_path }
        }.to change(ToolUser, :count).by(1)

        expect(ToolUser.last.tool).to eq(tool)
        expect(ToolUser.last.user).to eq(user)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new ToolUser association' do
        expect {
          post tool_users_path, params: { tool_user: invalid_attributes }, headers: {
            referer: root_path }
        }.to change(ToolUser, :count).by(0)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested ToolUser association' do
      expect {
        delete tool_user_path(tool_user), headers: {
          referer: root_path }
      }.to change(ToolUser, :count).by(-1)
    end
  end
end
