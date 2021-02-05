# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, :type => :model do
  it { is_expected.to validate_presence_of(:body) }

  it { is_expected.to belong_to(:group) }
  it { is_expected.to belong_to(:membership) }
end
