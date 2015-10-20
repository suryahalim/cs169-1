json.array!(@waitlists) do |waitlist|
  json.extract! waitlist, :id
  json.url waitlist_url(waitlist, format: :json)
end
