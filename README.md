# Quake Log Parser Rails app

## Instructions for live demo

https://quake-log-parser-rails-app.onrender.com

```bash
# Upload the quake.log file to the API + Save the response to a file (formatted JSON with jq)
curl -F quake_file=@/path/to/your/quake.log https://quake-log-parser-rails-app.onrender.com/quake_log_parse | jq > api_response.json

# Check the response from the API (formatted JSON)
cat api_response.json
```

## Instructions for localhost

```bash
# Clone the repository
git clone https://github.com/pedrofurtado/quake-log-parser-rails-app.git
cd quake-log-parser-rails-app

# Build and run the docker containers
docker-compose up --build -d

# Upload the quake.log file to the API + Save the response to a file (formatted JSON with jq)
curl -F quake_file=@/path/to/your/quake.log http://localhost:3000/quake_log_parse | jq > api_response.json

# Check the response from the API (formatted JSON)
cat api_response.json
```

## Instructions to produce/consume Kafka messages in localhost

```bash
# Produce
docker container exec -it quake-log-parser-rails-app_web_1 bundle exec rake kafka:produce_message

# Consume
docker container logs -f quake-log-parser-rails-app_kafka_consumer_1
```
