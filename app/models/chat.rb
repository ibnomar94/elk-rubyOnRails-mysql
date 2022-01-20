# frozen_string_literal: true

class Chat < ApplicationRecord
    belongs_to :application
    has_many :messages

    def publish_to_dashboard
        Publisher.publish('chats', attributes)
    end
    
end
