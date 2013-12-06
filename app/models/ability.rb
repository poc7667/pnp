class Ability
  include CanCan::Ability

   def basic_read_only
    can :read, :all
    can :list, :all
    can :search, :all
  end

  def basic_operation
    # can :read, :all
    # can :list, :all
    # can :edit, :all
    # can :create, :all
    # can :search, :all
  end

  def initialize(user)

    if user.blank?
      cannot :manage, :all
      # basic_read_only
      return
    end

    # binding.pry

    # user ||= User.new # guest user (not logged in)

    if 'admin' == user.role
      can :manage, :all
    else
      cannot :manage, :all
      basic_operation
      # cannot :read, Welcome
    end

  end

end