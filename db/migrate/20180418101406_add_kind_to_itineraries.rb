class AddKindToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :kind, :string
  end
end
