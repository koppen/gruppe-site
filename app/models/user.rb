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
  has_many :group_users, :through => :memberships
  has_many :groups, :through => :group_users
end
