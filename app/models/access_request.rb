class AccessRequest < ActiveRecord::Base
	enum status: [:open, :closed]
	belongs_to :user
end
