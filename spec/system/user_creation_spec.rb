require 'rails_helper'

RSpec.describe 'User creation', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:user) { build(:user) }
  let(:invalid_params) { attributes_for(:user, first_name: '', last_name: '')}

  describe 'a user can be created through an HTML form' do
    context 'with valid parameters' do
      it 'creates a new user' do
        visit users_path
        within('.form-container form') do
          fill_in 'First name', with: user.first_name
          fill_in 'Last name', with: user.last_name
          click_button 'Create User'
        end

        expect(page).to have_content(user.name)
      end
    end

    context 'with invalid parameters' do
      it 'responds with an error message' do
        visit users_path
        within('.form-container form') do
          fill_in 'First name', with: invalid_params[:first_name]
          fill_in 'Last name', with: invalid_params[:last_name]
          click_button 'Create User'
        end

        expect(page).to have_content('First name can\'t be blank')
        expect(page).to have_content('Last name can\'t be blank')
      end
    end
  end
end
