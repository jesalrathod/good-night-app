require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user_1) { User.new(name: 'Bob Marle') }
  let(:user_2) { User.new(name: 'Justin Timber') }
  let(:follow) { Follow.new(follower: user_2, followee: user_1) }

  describe "#follower_id" do
    it { should belong_to(:follower) }

    context "with invalid value" do
      it "should be invalid" do
        follow.follower_id = nil
        follow.followee_id = 1
        expect(follow).to_not be_valid
      end
    end

    context "with valid value" do
      it "should be valid" do
        expect(follow).to be_valid
      end
    end
  end

  describe "#followee_id" do
    it { should belong_to(:followee) }

    context "with invalid value" do
      it "should be invalid" do
        follow.follower_id = 2
        follow.followee_id = nil
        expect(follow).to_not be_valid
      end
    end

    context "with valid value" do
      it "should be valid" do
        expect(follow).to be_valid
      end
    end
  end
end
