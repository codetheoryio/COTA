class User < ActiveRecord::Base
  rolify

  has_one :candidate
  after_create :assign_default_role
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  def self.create_new_candidate_user(params)
    user = User.create!(params)
    user.add_role(:candidate) unless user.has_role? :candidate
    user
  end

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def name
    first_name + " " + last_name
  end
end
