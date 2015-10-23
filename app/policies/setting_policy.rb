class SettingPolicy < ApplicationPolicy
	attr_reader :user, :setting
	
	def initialize(user, setting)
    @user = user
    @setting = setting
  end
	def index?
	  user.admin?
	end
	def show?
		user.admin?
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