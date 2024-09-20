Rails.application.routes.draw do
  post "quake_log_parse" => "application#quake_log_parse"
end
