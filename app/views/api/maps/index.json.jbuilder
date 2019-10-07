json.set! :data do
  json.array! @api_maps do |api_map|
    json.partial! 'api_maps/api_map', api_map: api_map
    json.url  "
              #{link_to 'Show', api_map }
              #{link_to 'Edit', edit_api_map_path(api_map)}
              #{link_to 'Destroy', api_map, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end