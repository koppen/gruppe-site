# frozen_string_literal: true

# Adds a User to a Group, creating the Member and GroupUser objects
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
    Member.new(:user => user)
  end

  def build_group_user(group, member)
    GroupUser.new(:group => group, :member => member)
  end
end
