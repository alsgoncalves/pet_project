class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def update?
    user.can_edit? record
  end

  def destroy?
    user.is_owner? record
  end

  def new_post?
    user.can_add_posts_for? record
  end

  def new_event?
    user.can_add_events_for? record
  end
end
