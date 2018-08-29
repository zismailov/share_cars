class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :trip, foreign_key: true
      t.string :sender_name
      t.string :sender_email
      t.string :body
      t.text :message

      t.timestamps
    end
  end
end
