require 'rails_helper'

RSpec.describe SearchController, type: :request do
  let!(:user) { create(:user) }
  let!(:tool) { create(:tool) }
  let!(:category) { create(:category, name: 'foo') }
  let!(:other_user) { create(:user, first_name: 'Joe', last_name: 'Bloggs') }

  describe 'GET /index' do
    it 'renders the search index' do
      get search_index_path, params: { query: 'foo' }
      expect(response).to be_ok
      expect(response).to render_template(:index)
    end

    it 'returns search results that match the query' do
      get search_index_path, params: { query: 'foo' }
      expect(response.body).to include('foo bar (User)')
      expect(response.body).to include('foo (Tool)')
      expect(response.body).to include('foo (Category)')
    end

    it 'doesn\'t return search results that don\'t match the query' do
      get search_index_path, params: { query: 'foo' }
      expect(response.body).to_not include('Joe Bloggs (User)')
    end
  end
end
