class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post

  end

  def new?
    user.admin? or check_blog_access(user, post.commentaryid)
  end
  def create?
    user.admin? or check_blog_access(user, post.commentaryid)
  end
  def index?
    user.admin? or check_blog_access(user, post.first.commentaryid)
  end

  def list?
  	user.admin? or check_blog_access(user, post.first.commentaryid)
  end
  def edit?
    user.admin? or check_blog_access(user, post.commentaryid)
  end
  def destory?
    user.admin? or check_blog_access(user, post.commentaryid)
  end
  def update?
    user.admin? or check_blog_access(user, post.commentaryid)
  end

  private 
  # this is almost identical to post helper function
  def check_blog_access(user, commentaryid)
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