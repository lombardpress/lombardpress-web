class AccessRequestPolicy < ApplicationPolicy
	def initialize(user, access_request)
    @user = user
    @access_request = access_request
  end
  def index?
  	user.admin?
  end
	def show?
		user.admin? or user.id == @access_request.user_id
	end
	def new?
		user.admin?
	end
	def create?
		user_signed_in?
	end
	def destroy?
		user.admin?
	end
	def update?
		user.admin?
	end

end