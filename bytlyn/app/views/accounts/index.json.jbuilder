json.array!(@accounts) do |account|
  json.extract! account, :id, :email, :rest, :name
  json.url account_url(account, format: :json)
end
