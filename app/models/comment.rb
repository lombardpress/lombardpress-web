require 'net/http'
require 'uri'
require 'lbp'

class Comment < ActiveRecord::Base
	enum access_type: [:general, :editorial, :personal]
  belongs_to :user

	def send_ldn(comment_params)
		inbox = Lbp::Resource.find("http://scta.info/resource/#{comment_params[:pid]}").inbox.to_s
		target = "http://scta.info/resource/#{comment_params[:pid]}"

		ldn = {
		  "@context": "http://www.w3.org/ns/anno.jsonld",
		  "id": "http://example.org/example1",
		  "type": "Annotation",
		  "motivation": "commenting",
		  "updated": "test",
		  "body": {
		    "type": "TextualBody",
		    "value": comment_params[:comment]
		  },
		  "target": target
		}

		uri = URI.parse(inbox)

		http = Net::HTTP.new(uri.host)
		req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json+ld')
		req.body = ldn.to_json
		res = http.request(req)
	end
end
