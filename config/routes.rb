Rails.application.routes.draw do
  get '/welcome', to: 'welcome#hello'
  root to: "welcome#hello"
end
