class UserPolicy < ApplicationPolicy
	attr_reader :user, :profile
	
	def initialize(user, profile)
    @user = user
    @profile = profile
  end
	def index?
	  user.admin?
	end
	def show?
		user.admin? or user.id == profile.id
	end
	def create?
		user.admin?
	end
	def destroy?
		user.admin?
	end
	def update?
		user.admin?
	end

end