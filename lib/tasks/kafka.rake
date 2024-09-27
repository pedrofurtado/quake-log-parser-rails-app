namespace :kafka do
  desc 'Kafka produce message'
  task produce_message: :environment do
    topic_name = 'quake_log_parser_rails_app_topic'
    key = SecureRandom.uuid
    payload = {
      "lines" => [
        "0:00 InitGame: \\sv_floodProtect\\1\\sv_maxPing\\0\\sv_minPing\\0\\sv_maxRate\\10000\\sv_minRate\\0\\sv_hostname\\Code Miner Server\\g_gametype\\0\\sv_privateClients\\2\\sv_maxclients\\16\\sv_allowDownload\\0\\dmflags\\0\fraglimit\\20\\timelimit\\15\\g_maxGameClients\\0\\capturelimit\\8\\version\\ioq3 1.36 linux-x86_64 Apr 12 2009\\protocol\\68\\mapname\\q3dm17\\gamename\baseq3\\g_needpass\\0",
        "20:34 ClientUserinfoChanged: 2 n\\Isgalamido\\t\\0\\model\\xian/default\\hmodel\\xian/default\\g_redteam\\g_blueteam\\c1\\4\\c2\\5\\hc\\100\\w\\0\\l\\0\\tt\\0\\tl\\0",
        "20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT",
        "21:51 ClientUserinfoChanged: 3 n\\Dono da Bola\\t\\0\\model\\sarge/krusade\\hmodel\\sarge/krusade\\g_redteam\\g_blueteam\\c1\\5\\c2\\5\\hc\\95\\w\\0\\l\\0\\tt\\0\\tl\\0",
        "22:06 Kill: 2 3 7: Isgalamido killed Dono da Bola by MOD_ROCKET_SPLASH"
      ]
    }
    producer = Karafka.producer.produce_sync(topic: topic_name, payload: payload.to_json, key: key)
    Rails.logger.info("[RailsApp::KafkaTopicProducer] send_sync topic=#{topic_name} key=#{key} offset=#{producer.offset} partition=#{producer.partition} payload=#{payload}")
  end
end
