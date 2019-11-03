# frozen_string_literal: true

# Create a Group in the system
class CreateGroup < Substance::Operation
  def process(group_attributes)
    group = build_group(group_attributes)
    member = build_member(user)
    group.memberships = [member]

    self.success = group.save
    self.result = group
  end

  private

  def build_group(attributes)
    Group.new(attributes)
  end

  def build_member(user)
    Membership.new(:user => user)
  end
end
