class GeonamesController < ApplicationController
  COUNTRY_SEARCH_LIST = "kg,ru,kz".freeze

  def autocomplete
    @results = Geoname.search_by_name(params[:term]).limit(5)
  end
end
