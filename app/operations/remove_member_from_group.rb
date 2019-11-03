# frozen_string_literal: true

# Removes a Member from a Group
class RemoveMemberFromGroup < Substance::Operation
  def process(member, group)
    group_user = find_group_user(member, group)

    self.success = group_user&.destroy
    self.result = group_user
  end

  private

  def find_group_user(member, group)
    group.group_users.where(:member => member).first
  end
end
