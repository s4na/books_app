json.extract! report, :id, :title, :emotion, :body, :author, :datetime, :created_at, :updated_at
json.url report_url(report, format: :json)
