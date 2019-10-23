# frozen_string_literal: true

# Removes a Member from a Group
class RemoveMemberFromGroup < Substance::Operation
  def process(member, group)
    membership = find_membership(member, group)

    self.success = membership&.destroy
    self.result = membership
  end

  private

  def find_membership(member, group)
    group.memberships.where(:member => member).first
  end
end
