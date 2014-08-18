json.array!(@orders) do |order|
  json.extract! order, :id, :user_id, :address, :pay_status, :pay_type
  json.url order_url(order, format: :json)
end
