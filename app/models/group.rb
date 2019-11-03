# frozen_string_literal: true

class Group < ApplicationRecord
  validates :name, :presence => true

  has_many :invitations, :dependent => :destroy
  has_many :members, :dependent => :destroy
  has_many :memberships, :through => :members

  def to_s
    name
  end
end
