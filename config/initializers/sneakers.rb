require 'sneakers'
require 'bunny'

Sneakers.configure :connection => Bunny.new(host:  'rabbitmq',
port:  '5672',
vhost: '/',
user:  'guest',
pass:  'guest')
