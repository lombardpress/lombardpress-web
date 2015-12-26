class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def new?
    user.admin? or user.reader?
  end
  def create?
    user.admin? or user.reader?
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