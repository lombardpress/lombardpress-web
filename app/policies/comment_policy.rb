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

  def destroy?
    user.admin? or check_editor_access(user, comment.itemid, comment.commentaryid) or comment.user_id == user.id
  end
  def destroy_alt?
    user.admin? or check_editor_access(user, comment.itemid, comment.commentaryid) or comment.user_id == user.id
  end

  def edit?
    user.admin?
  end
  
  def update?
    user.admin?
  end

  private 
  #nearl identical to the function in the application helper
  def check_editor_access(user, itemid, commentaryid)
    answer = false
    user.access_points.each do |ap| 
      if ap.editor? && ap.itemid == "all" && ap.commentaryid == commentaryid
        answer = true
        break
      end  
    end
    return answer
  end
end