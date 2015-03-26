class User < ActiveRecord::Base
  
	enum role: [:admin, :commentary_admin, :editor, :draft_img_reader, :draft_reader, :public_reader]
  after_initialize :set_default_role, :if => :new_record?
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def set_default_role
  	self.role ||= :public_reader
  end
end
