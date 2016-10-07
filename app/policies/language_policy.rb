# frozen_string_literal: true
class LanguagePolicy < ApplicationPolicy
  def edit?
    user.admin
  end

  def create?
    user.admin
  end

  def update?
    user.admin
  end

  def destroy?
    user.admin
  end
end
