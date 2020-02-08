# frozen_string_literal: true

require "rails_helper"

RSpec.describe Membership, :type => :model do
  it { should belong_to(:user) }
  it { should have_many(:posts) }
end
