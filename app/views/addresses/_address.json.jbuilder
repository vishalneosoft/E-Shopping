json.extract! address, :id, :name, :address1, :address2, :city, :state, :country, :pincode, :phone, :user_id, :created_at, :updated_at
json.url address_url(address, format: :json)