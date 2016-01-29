class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def new?
    user.admin? or user.user?
  end

  def index?
    user.admin? or user.user?
  end
  
  def create?
    user.admin? or user.user?
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