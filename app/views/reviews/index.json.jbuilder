json.array!(@reviews) do |review|
  json.extract! review, :id, :review_title
  json.url review_url(review, format: :json)
end
