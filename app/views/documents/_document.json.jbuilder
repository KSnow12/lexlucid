json.extract! document, :id, :name, :url, :description, :version, :created_at, :updated_at
json.url document_url(document, format: :json)
