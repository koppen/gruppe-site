# frozen_string_literal: true

require "rails_helper"

RSpec.describe Invitation, :type => :model do
  it { should validate_presence_of(:email) }
end
