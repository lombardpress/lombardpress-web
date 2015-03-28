class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def new?
    user.admin?
  end

  def list?
  	user.admin?
  end
  def edit?
    user.admin?
  end
  def destory?
    user.admin?
  end
  def update?
    user.admin?
  end
end