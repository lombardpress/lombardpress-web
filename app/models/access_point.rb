#this is a poorly named model 
#it does not exactly coorrespond to the text controller
#it probably should be renamed to something like
# 'AccessPoint'
class AccessPoint < ActiveRecord::Base
	has_and_belongs_to_many :users
end
