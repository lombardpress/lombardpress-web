class AccessPointPolicy < ApplicationPolicy
	def show?
		puts "test"
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