class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    validates :body , presence: true
    belongs_to :chat

    index_name Rails.application.class.parent_name.underscore
    document_type self.name.downcase

    def self.search(query)
        __elasticsearch__.search(
        {
          query: {
             match: {
               query: query,
               fields: ['body']
             }
           }
        })
    end

    settings index: { number_of_shards: 1 } do
        mapping dynamic: false do
          indexes :body, analyzer: 'english'
        end
    end
end