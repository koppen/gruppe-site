# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_secure_token

  validates :email, :presence => true
end
