# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :group
  belongs_to :membership

  validates :body, :presence => true
end
