class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :read, Note, user_id: user.id
    can :update, Note, user_id: user.id

    # can read any notes they're a viewer of
    can :read, Note do |note|
      note.readers.include? user
    end

  end
end
