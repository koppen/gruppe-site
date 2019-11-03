# frozen_string_literal: true

class Group < ApplicationRecord
  validates :name, :presence => true

  has_many :invitations, :dependent => :destroy
  has_many :group_users, :dependent => :destroy
  has_many :members, :through => :group_users

  def to_s
    name
  end
end
