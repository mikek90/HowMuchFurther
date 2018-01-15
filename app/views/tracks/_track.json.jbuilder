json.extract! track, :id, :user_id, :latitude_from, :longtitude_from, :latitude_to, :longtitude_to, :json_response, :json_processed, :created_at, :updated_at
json.url track_url(track, format: :json)
