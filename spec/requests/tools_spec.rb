require 'rails_helper'

RSpec.describe ToolsController, type: :request do
  let!(:tool) { create(:tool) }
  let(:invalid_attributes) { attributes_for(:tool, name: '') }

  describe 'GET /index' do
    it 'renders a successful response' do
      get tools_path
      expect(response).to be_ok
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get tool_path(tool)
      expect(response).to be_ok
      expect(response).to render_template(:show)
      expect(response.body).to include(tool.name)
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_tool_path(tool)
      expect(response).to be_ok
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Tool' do
        expect {
          post tools_path, params: { tool: attributes_for(:tool, name: 'test') }
        }.to change(Tool, :count).by(1)

        expect(flash[:notice]).to eq 'New tool successfully created!'
        expect(response).to redirect_to(tools_path)
        expect(Tool.last.name).to eq('test')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Tool' do
        expect {
          post tools_path, params: { tool: invalid_attributes }
        }.to change(Tool, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('["Name can\'t be blank"]')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:tool, name: 'test') }

      it 'updates the requested tool' do
        patch tool_path(tool), params: { tool: new_attributes }
        tool.reload
        expect(tool.name).to eq('test')
        expect(response).to redirect_to(tool_path(tool))
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested tool' do
        patch tool_path(tool), params: { tool: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('["Name can\'t be blank"]')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested tool' do
      expect {
        delete tool_path(tool)
      }.to change(Tool, :count).by(-1)
      expect(response).to redirect_to(tools_path)
    end
  end
end
