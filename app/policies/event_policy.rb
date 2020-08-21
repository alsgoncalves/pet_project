class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new_participation?
    true
  end

  def show?
    true
  end


end
