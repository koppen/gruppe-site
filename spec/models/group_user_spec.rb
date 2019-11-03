# frozen_string_literal: true

require "rails_helper"

RSpec.describe GroupUser, :type => :model do
  it { should belong_to(:group) }
  it { should belong_to(:membership).dependent(true) }

  describe "#destroy" do
    subject {
      FactoryBot.create(:group_user)
    }

    it "destroys the associated Membership" do
      subject.destroy
      expect {
        subject.membership.reload
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
