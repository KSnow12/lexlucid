json.extract! rating, :id, :bullet_point_id, :score, :description, :review_id, :created_at, :updated_at
json.url rating_url(rating, format: :json)
