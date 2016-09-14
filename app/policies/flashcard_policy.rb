class FlashcardPolicy < ApplicationPolicy
  def edit?
    record.user == user or user.admin
  end

  def update?
    record.user == user or user.admin
  end

  def destroy?
    record.user == user or user.admin
  end
end
