class ChatsWorker
    include Sneakers::Worker
  
    from_queue "dashboard.chats", env: nil
    def work(raw_chat)
      Chat.create(raw_chat)
      ack! 
    end
  end