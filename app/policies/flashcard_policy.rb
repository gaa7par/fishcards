# frozen_string_literal: true
class FlashcardPolicy < ApplicationPolicy
  def edit?
    (record.user == user) || user.admin
  end

  def update?
    (record.user == user) || user.admin
  end

  def destroy?
    (record.user == user) || user.admin
  end
end
