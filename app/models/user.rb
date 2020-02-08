# frozen_string_literal: true

class User < ApplicationRecord
  devise \
    :database_authenticatable,
    :recoverable,
    :registerable,
    :rememberable,
    :trackable,
    :validatable

  has_many :memberships, :dependent => :destroy
  has_many :members, :through => :memberships
  has_many :groups, :through => :members

  has_many :posts, :through => :memberships, :dependent => :destroy
end
