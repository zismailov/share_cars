class GeonamesController < ApplicationController
  COUNTRY_SEARCH_LIST = "kg,ru,kz".freeze

  def autocomplete
    @results = Geoname.search(params[:term], fields: [{ place_name: :word_start }], limit: 10)
  end
end
