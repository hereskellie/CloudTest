json.array!(@tours) do |tour|
  json.extract! tour, :id, :firstname, :lastname, :language, :cost, :description
  json.url tour_url(tour, format: :json)
end
