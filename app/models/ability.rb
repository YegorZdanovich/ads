class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new

    if user.role.admin?
      can :mange,:all
    elsif user.role.user?
      can [:read, :write], :all
    elsif user.role.guest?
      can :read, :all
    end
          

    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
