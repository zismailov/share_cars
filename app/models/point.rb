class Point < ApplicationRecord
  belongs_to :trip

  attr_accessor :location_name, :location_coordinates

  def as_json(_options = {})
    super(
      only: %i[kind rank city]
    ).merge(location: {
              lat: lat.to_f, lon: lon.to_f
            })
  end
end
