# frozen_string_literal: true

# A connection between a Group and a User
#
# This is the group-controllable part of a Users participation in a Group.
class Member < ApplicationRecord
  belongs_to :group
  belongs_to :membership, :dependent => :destroy

  delegate :name, :email, :to => :membership
end
