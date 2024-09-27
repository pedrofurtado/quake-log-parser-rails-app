$stdout.sync = true
$stderr.sync = true

ENV['KARAFKA_ENV'] ||= 'development'

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = {
      'bootstrap.servers': 'kafka:9092',
      'allow.auto.create.topics': false
    }
    config.client_id = 'quake_log_parser_rails_app_client'
    config.initial_offset = 'earliest'
    config.consumer_persistence = ENV['KARAFKA_ENV'] != 'development'
  end

  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new(log_polling: false))
  Karafka.producer.monitor.subscribe(
    WaterDrop::Instrumentation::LoggerListener.new(
      Karafka.logger,
      log_messages: false
    )
  )

  routes.draw do
    topic :quake_log_parser_rails_app_topic do
      config(partitions: 3)
      consumer ::QuakeLogParser::KafkaTopicConsumer
      dead_letter_queue(
        topic: 'quake_log_parser_rails_app_dead_letter_topic',
        max_retries: 0,
        independent: false
      )
    end
  end
end
