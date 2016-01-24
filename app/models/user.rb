class User < ActiveRecord::Base
  
  enum role: [:admin, :user]
  enum language: { en: 'en', de: 'de', fr: 'fr', la: 'la'}
	has_many :comments, dependent: :destroy
	has_many :posts, dependent: :destroy
  has_many :access_requests, dependent: :destroy
	has_and_belongs_to_many :access_points

  after_initialize :set_default_role, :if => :new_record?
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def set_default_role
  	self.role ||= :user
  end
end
