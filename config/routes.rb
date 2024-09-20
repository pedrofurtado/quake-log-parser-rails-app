Rails.application.routes.draw do
  root "application#index"
  get "test" => "application#test"
  get "test2" => "application#test2"
  post "quake_log_parse" => "application#quake_log_parse"
end
