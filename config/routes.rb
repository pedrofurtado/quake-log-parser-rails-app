Rails.application.routes.draw do
  root to "application#index"
  get "test" => "application#test"
  post "quake_log_parse" => "application#quake_log_parse"
end
