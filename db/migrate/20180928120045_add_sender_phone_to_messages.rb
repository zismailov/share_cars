class AddSenderPhoneToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :sender_phone, :string
  end
end
