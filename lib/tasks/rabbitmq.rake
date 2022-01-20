require 'sneakers/tasks'

namespace :rabbitmq do
    desc "Connect consumer to producer"
    task :setup do
      require "bunny"
      conn = Bunny.new(host:  'rabbitmq',
      port:  '5672',
      vhost: '/',
      user:  'guest',
      pass:  'guest').tap(&:start)
      ch = conn.create_channel
      queue_chats = ch.queue("dashboard.chats")
      # bind queue to exchange
      queue_chats.bind("crawler.chats")
      conn.close
    end
  end