class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new

    if user.role.admin?
      can :read, [Advertisement, Profile]
      can :update, [Profile]
      can :update, [Advertisement] {|a| a.new?}
      can :destroy, [Profile] {|p| p.user_id != user.id}
      can :destroy, [Advertisement]
      can :browse, [Advertisement, Profile]
    elsif user.role.user?
      
      can :read, Profile do |p|
        p.user_id == user.id
      end

      can :create, [Advertisement]
      can :read, [Advertisement] {|a| a.published? || (a.user.id == user.id)}
      can [:update, :destroy], [Advertisement] do |a| 
        a.user_id == user.id && ( a.draft? || a.archival?)
      end
      #can [:read, :create, :update], [Advertisement, Profile]

    elsif user.role.guest?
      can :read, [Advertisement] {|a| a.published?}
    end
          

    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
