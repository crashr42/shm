class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
    end

    if user.role? :doctor
      can :access, :doctor_cabinet
    end

    if user.role? :patient
      can :access, :patient_cabinet
    end

    if user.role? :manager
      can :access, :manager_cabinet
    end
  end
end
