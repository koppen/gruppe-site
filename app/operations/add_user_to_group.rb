# frozen_string_literal: true

# Adds a User to a Group, creating the Membership and Member objects
class AddUserToGroup < Substance::Operation
  def process(user, group)
    member = build_membership(user)
    member = build_member(group, member)

    self.success = member.save
    self.result = member
  end

  private

  def build_group(attributes)
    Group.new(attributes)
  end

  def build_membership(user)
    Membership.new(:user => user)
  end

  def build_member(group, member)
    Member.new(:group => group, :membership => member)
  end
end
