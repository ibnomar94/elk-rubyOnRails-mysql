class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.bigint :application_id  , :null => false
      t.integer :number  , :null => false , :default => 1
      t.integer :message_count  , :null => false , :default => 0

      t.timestamps
    end
    #add a foreign key
    execute <<-SQL
      ALTER TABLE chats
        ADD CONSTRAINT fk_chat_application
        FOREIGN KEY (application_id)
        REFERENCES applications(id)
    SQL
  end
end
