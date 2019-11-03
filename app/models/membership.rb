# frozen_string_literal: true

# A Membership is a users participation in a group. It is different from a User
# in that a Membership doesn't have to bear any resemblance to a real person.
#
# Basically, this is how the user chooses to represent herself in a specific
# group and her preferences for how to interact with that group.
#
# Basically, Membership is controlled by the User, whereas Member is controlled
# by the Group (owners).
class Membership < ApplicationRecord
  belongs_to :user
  has_one :member, :dependent => :destroy

  delegate :email, :to => :user
  delegate :group, :to => :member
end
