json.array!(@access_requests) do |access_request|
  json.extract! access_request, :id, :user, :itemid, :commentaryid, :note
  json.url access_request_url(access_request, format: :json)
end
