# frozen_string_literal: true

require "rails_helper"

RSpec.describe Member, :type => :model do
  it { is_expected.to belong_to(:group) }
  it { is_expected.to belong_to(:membership).dependent(true) }

  describe "#destroy" do
    subject {
      FactoryBot.create(:member)
    }

    it "destroys the associated Membership" do
      subject.destroy
      expect {
        subject.membership.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
