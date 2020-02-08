# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, :type => :model do
  it { should validate_presence_of(:body) }

  it { should belong_to(:group) }
  it { should belong_to(:membership) }
end
