# frozen_string_literal: true

# A Member is the participant in a group. It is different from a User in that a
# Member doesn't have to bear any resemblance to a real person.
#
# A Member is the way a User decides to present themselves to a specific Group.
#
# Basically, Member is controlled by the User, whereas Membership is controlled
# by the Group (owners).
class Member < ApplicationRecord
  belongs_to :user
  has_one :membership, :dependent => :destroy

  delegate :email, :to => :user
end
