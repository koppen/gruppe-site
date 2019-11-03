# frozen_string_literal: true

# A Membership is the participant in a group. It is different from a User in that a
# Membership doesn't have to bear any resemblance to a real person.
#
# A Membership is the way a User decides to present themselves to a specific Group.
#
# Basically, Membership is controlled by the User, whereas Member is controlled
# by the Group (owners).
class Membership < ApplicationRecord
  belongs_to :user
  has_one :member, :dependent => :destroy

  delegate :email, :to => :user
end
