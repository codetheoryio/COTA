class User < ActiveRecord::Base
  rolify

  has_one :candidate
  after_create :assign_default_role
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.create_new_user(params)
    User.create!(params)
  end

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def name
    first_name + " " + last_name
  end
end
