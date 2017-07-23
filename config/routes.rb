Rails.application.routes.draw do
  root to: "vote_counts#dashboard"
  get 'vote_counts/graph'
  get 'update-api.json', to: "vote_counts#update_api"
end
