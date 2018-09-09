class AddLocationIndexToPoints < ActiveRecord::Migration[5.2]
  def change
    execute %{
      create index index_on_points_location ON points using gist (
        ST_GeographyFromText(
          'SRID=4326;POINT(' || points.lon || ' ' || points.lat || ')'
        )
      )
    }
  end
  
  def down
    execute %{drop index index_on_points_location}
  end
end