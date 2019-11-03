# frozen_string_literal: true

# Adds a User to a Group, creating the Membership and GroupUser objects
class AddUserToGroup < Substance::Operation
  def process(user, group)
    member = build_member(user)
    group_user = build_group_user(group, member)

    self.success = group_user.save
    self.result = group_user
  end

  private

  def build_group(attributes)
    Group.new(attributes)
  end

  def build_member(user)
    Membership.new(:user => user)
  end

  def build_group_user(group, member)
    GroupUser.new(:group => group, :membership => member)
  end
end
