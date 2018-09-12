class GeocodesController < ApplicationController
  # for Nominatim
  #  COUNTRY_SEARCH_LIST = "kg,ru,kz".freeze
  #  def autocomplete
  #   render json: Geocoder.search(params[:term], params: {countrycodes: COUNTRY_SEARCH_LIST}).map(&:data)
  #  end

  # for Google
  #  Geocoder.search("Lille").map(&:data).first["geometry"]["location"]
  #  => {"lat"=>50.62925, "lng"=>3.057256}
  #  Geocoder.search("Lille").map(&:data).first["address_components"][0]["short_name"]
  #  => "Lille"

  #
  # Should return :
  #  [{ display_name: "Lille", lat: ..., lon: ...}, {}]
  #
  def autocomplete
    @results = Geocoder.search(params[:term])
  end
end
