class CreateItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :itineraries do |t|
      t.datetime :leave_at, null: false
      t.integer :seats
      t.string :comfort
      t.text :description
      t.integer :price
      t.string :title
      t.boolean :smoking, default: false, null: false
      t.string :name
      t.integer :age
      t.string :email
      t.string :phone
      t.string :creation_token
      t.string :edition_token
      t.string :deletion_token
      t.integer :state, default: 0
      t.string :state, default: 'pending'
      t.string :creation_ip
      t.string :deletion_ip

      t.timestamps
    end
  end
end
