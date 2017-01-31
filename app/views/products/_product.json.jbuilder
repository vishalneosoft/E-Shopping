json.extract! product, :id, :name, :sku, :short_description, :long_description, :price, :status, :quantity, :created_at, :updated_at
json.url product_url(product, format: :json)