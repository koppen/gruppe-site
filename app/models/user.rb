# frozen_string_literal: true

class User < ApplicationRecord
  devise \
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :trackable,
    :validatable

  has_many :members, :dependent => :destroy
  has_many :memberships, :through => :members
  has_many :groups, :through => :memberships
end
