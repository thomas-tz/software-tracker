class SearchController < ApplicationController
  def index
    @search_results =
      PgSearch
        .multisearch(search_params)
        .map { |result| result.searchable_type.constantize.find(result.searchable_id) }
  end

  private
  def search_params
    params.require(:query)
  end
end
