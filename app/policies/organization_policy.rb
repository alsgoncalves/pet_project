class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def show
      return true
    end

    def create?
      return true
    end

    def update?
      user.can_edit? record
    end

    def destroy?
      user.is_owner? record
    end
  end

end
