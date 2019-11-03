# frozen_string_literal: true

# A connection between a Group and a User
class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :membership, :dependent => :destroy
end
