class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.bigint :chat_id , :null => false
      t.integer :number , :null => false , :default => 1
      t.text :body , :null => false

      t.timestamps
    end
    #add a foreign key
    execute <<-SQL
      ALTER TABLE messages
        ADD CONSTRAINT fk_message_chat
        FOREIGN KEY (chat_id)
        REFERENCES chats(id)
    SQL
  end
end
