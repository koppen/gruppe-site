# frozen_string_literal: true

class Group < ApplicationRecord
  validates :name, :presence => true

  has_many :memberships, :dependent => :destroy
  has_many :members, :through => :memberships

  def to_s
    name
  end
end
