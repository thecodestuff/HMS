json.extract! api_map, :id, :name, :lat, :long, :created_at, :updated_at
json.url api_map_url(api_map, format: :json)
