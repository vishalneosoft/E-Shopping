json.extract! transaction, :id, :charge, :charge_id, :amount, :stripetoken, :stripeemail, :order_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)