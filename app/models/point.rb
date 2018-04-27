class Point < ApplicationRecord
  belongs_to :trip

  def as_json(_options = {})
    super(
      only: %i[kind rank city]
    ).merge(location: {
              lat: lat.to_f, lon: lon.to_f
            })
  end
end
