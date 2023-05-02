require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let!(:user) { create(:user) }
  let(:invalid_attributes) { attributes_for(:user, first_name: '', last_name: '') }

  describe 'GET /index' do
    it 'renders a successful response' do
      get users_path
      expect(response).to be_ok
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get user_path(user)
      expect(response).to be_ok
      expect(response).to render_template(:show)
      expect(response.body).to include(user.name)
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_user_path(user)
      expect(response).to be_ok
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect {
          post users_path, params: { user: attributes_for(:user, first_name: 'first_test', last_name: 'last_test') }
        }.to change(User, :count).by(1)

        expect(flash[:notice]).to eq 'New user successfully created!'
        expect(response).to redirect_to(users_path)
        expect(User.last.first_name).to eq('first_test')
        expect(User.last.last_name).to eq('last_test')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect {
          post users_path, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('["First name can\'t be blank", "Last name can\'t be blank"]')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { attributes_for(:user, first_name: 'first', last_name: 'last') }

      it 'updates the requested user' do
        patch user_path(user), params: { user: new_attributes }
        user.reload
        expect(user.first_name).to eq('first')
        expect(user.last_name).to eq('last')
        expect(response).to redirect_to(user_path(user))
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested user' do
        patch user_path(user), params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('["First name can\'t be blank", "Last name can\'t be blank"]')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)
      expect(response).to redirect_to(users_path)
    end
  end
end
