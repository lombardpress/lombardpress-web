#I can't get this policy to work

class Lbp::ItemPolicy < ApplicationPolicy
	attr_reader :user, :item

  def initialize(user, item)
    @user = user
    @item = item
  end

	def show?
		user.admin?
	
	end

end
