class GeocodesController < ApplicationController
  COUNTRY_SEARCH_LIST = "kg,ru,kz".freeze

  def autocomplete
    @results = Geocoder.search(params[:term], countrycodes: COUNTRY_SEARCH_LIST).select { |res| res.data["address"]["city"] && res.data["address"]["postcode"] }
  end

  # for Google
  #  Geocoder.search("Lille").map(&:data).first["geometry"]["location"]
  #  => {"lat"=>50.62925, "lng"=>3.057256}
  #  Geocoder.search("Lille").map(&:data).first["address_components"][0]["short_name"]
  #  => "Lille"
end
