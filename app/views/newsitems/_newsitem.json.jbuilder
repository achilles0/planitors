json.extract! newsitem, :id, :name, :text, :created_at, :updated_at
json.url newsitem_url(newsitem, format: :json)
