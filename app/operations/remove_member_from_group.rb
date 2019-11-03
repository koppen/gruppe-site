# frozen_string_literal: true

# Removes a Membership from a Group
class RemoveMemberFromGroup < Substance::Operation
  def process(member, group)
    member = find_member(member, group)

    self.success = member&.destroy
    self.result = member
  end

  private

  def find_member(member, group)
    group.members.where(:membership => member).first
  end
end
