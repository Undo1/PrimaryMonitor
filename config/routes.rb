Rails.application.routes.draw do
  root to: "vote_counts#dashboard"
  get 'vote_counts/graph'
end
