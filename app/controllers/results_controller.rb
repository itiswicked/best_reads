class ResultsController < ApplicationController

  def index
     @pg_search_documents = PgSearch.multisearch(params[:query])
  end

end
