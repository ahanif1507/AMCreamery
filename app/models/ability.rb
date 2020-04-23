# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
      user ||= Employee.new # guest user (not logged in)
    
    if user.role? :admin
        can :manage, :all
    
    elsif user.role? :manager

      cannot :create, Employee
      cannot :destroy, Employee
      cannot :manage, Assignment
      can :manage, Shift
      can :show, Shift
      cannot [:create, :edit, :destroy], Job
      can :show, Assignment

    elsif user.role? :employee
      
      cannot :manage, Store 
      cannot :manage, Job 
      cannot :manage, Assignment 
      cannot :manage, Employee
      
      can :show, Employee do |e|
        e.id == user.id
      end
    
      can :show, Shift do |s|
        s.assignment.employee.id == user.id
      end

      can :show, Assignment do |a|
        a.employee.id == user.id
      end

    end



    
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
