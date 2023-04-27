class SearchController < ApplicationController
  def index
    @search_results = PgSearch.multisearch(search_params).map do |result|
      case result.searchable_type
      when "User"
        User.find(result.searchable_id)
      when "Tool"
        Tool.find(result.searchable_id)
      when "Category"
        Category.find(result.searchable_id)
      end
    end
  end

  private
  def search_params
    params.require(:query)
  end
end
