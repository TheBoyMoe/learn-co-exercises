class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # user roles
  enum role: [:user, :vip, :admin]

  has_many :posts

  def guest?
    persisted?
  end

  private
    def set_default_role
      self.role = :user
    end

end
