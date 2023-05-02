require 'rails_helper'

RSpec.describe CategoriesController, type: :request do
  let!(:category) { create(:category) }
  let(:invalid_attributes) { attributes_for(:category, name: '') }

  describe 'GET /index' do
    it 'renders a successful response' do
      get categories_path
      expect(response).to be_ok
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get category_path(category)
      expect(response).to be_ok
      expect(response).to render_template(:show)
      expect(response.body).to include(category.name)
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_category_path(category)
      expect(response).to be_ok
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect {
          post categories_path, params: { category: attributes_for(:category, name: 'test') }
        }.to change(Category, :count).by(1)

        expect(flash[:notice]).to eq 'New category successfully created!'
        expect(response).to redirect_to(categories_path)
        expect(Category.last.name).to eq('test')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect {
          post categories_path, params: { category: invalid_attributes }
        }.to change(Category, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('["Name can\'t be blank"]')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:category, name: 'test') }

      it 'updates the requested category' do
        patch category_path(category), params: { category: new_attributes }
        category.reload
        expect(category.name).to eq('test')
        expect(response).to redirect_to(category_path(category))
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested category' do
        patch category_path(category), params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('["Name can\'t be blank"]')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested category' do
      expect {
        delete category_path(category)
      }.to change(Category, :count).by(-1)
      expect(response).to redirect_to(categories_path)
    end
  end
end
