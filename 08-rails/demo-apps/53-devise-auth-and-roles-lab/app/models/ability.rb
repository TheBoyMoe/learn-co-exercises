class Ability
  include CanCan::Ability

  def initialize(user)
    # user.can :read, Post
    # user.con :create, Post
    # return if user.guest?
		#
    # user.can :manage, Post, {user_id: user.id}
    # return if user.user?
		#
    # user.can :update, Post
    # return if user.vip?
		#
    # # admins can manage posts and users
    # user.can :manage, :all if user.admin?

  end
end
