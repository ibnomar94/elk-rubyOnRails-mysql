class Application < ApplicationRecord
    before_create :set_token

    validates :name , presence: true
    has_many :chats

    def set_token
        self.token = SecureRandom.uuid 
    end
end
