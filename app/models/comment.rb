class Comment < ActiveRecord::Base
	enum access_type: [:general, :editorial, :personal]
  belongs_to :user
end
