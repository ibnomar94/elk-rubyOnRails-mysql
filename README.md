# README

- To start the whole stack : docker-compose up

- Run "rails db:migrate" after all the dockers are up to run the migrations

- The stack comes with "Adminer" which is a simple web interface to interact with the DB, it can be accessed through : http://localhost:8080/

- The stack also comes with "Kibana" which can be accessed through : http://localhost:5601/. Note 
that you will need to create an index pattern [http://localhost:5601/app/management/kibana/indexPatterns] in Kibana to be able to view the index and interact with it.
Index name : myapp

- RabbitMq is used a queueing system, its admin page can be accessed from : http://localhost:15672/ [user:guest , password:guest]

- I have added a "ChatApp.postman_collection.json" which is a postman collection holding the requests for the APIs

- After stack is up run :  WORKERS=ChatsWorker bundle exec rake sneakers:run