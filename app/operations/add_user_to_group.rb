# frozen_string_literal: true

# Adds a User to a Group, creating the Member and Membership objects
class AddUserToGroup < Substance::Operation
  def process(user, group)
    member = build_member(user)
    membership = build_membership(group, member)

    self.success = membership.save
    self.result = membership
  end

  private

  def build_group(attributes)
    Group.new(attributes)
  end

  def build_member(user)
    Member.new(:user => user)
  end

  def build_membership(group, member)
    Membership.new(:group => group, :member => member)
  end
end
