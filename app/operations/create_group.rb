# frozen_string_literal: true

# Create a Group in the system
class CreateGroup < Substance::Operation
  def process(group_attributes)
    group = Group.new(group_attributes)
    group.members = [user]
    self.success = group.save
    self.result = group
  end
end
