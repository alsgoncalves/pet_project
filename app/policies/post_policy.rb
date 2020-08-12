class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def show
      return true
    end

    def create?
      user.can_add_posts? record
    end
  end
end
