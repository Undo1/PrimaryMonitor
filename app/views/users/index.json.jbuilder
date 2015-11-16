json.array!(@users) do |user|
  json.extract! user, :id, :link, :display_name, :current_score, :profile_image
  json.url user_url(user, format: :json)
end
