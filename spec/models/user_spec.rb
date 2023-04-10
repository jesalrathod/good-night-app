require 'rails_helper'

RSpec.describe User, type: :model do

  describe "associations" do
    it { should have_many(:reverse_followings) }
    it { should have_many(:followings) }
    it { should have_many(:followers).through(:reverse_followings) }
    it { should have_many(:followees).through(:followings) }
  end

  it "is valid with name" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it "is not valid without name" do
    user = FactoryBot.create(:user)
    user.name = nil
    expect(user).to_not be_valid
  end

  describe '#follow' do
    let(:follower) { create(:user) }
    let(:followee) { create(:user) }

    it 'creates a relationship' do
      expect {
        follower.follow(followee)
      }.to change(Follow, :count).by(1)
    end

    it 'creates a follower_relationship for the follower' do
      follower.follow(followee)

      expect(follower.followees).to include(followee)
    end

    it 'creates a followee_relationship for the followee' do
      follower.follow(followee)

      expect(followee.followers).to include(follower)
    end
  end

  describe '#unfollow' do
    let(:follower) { create(:user) }
    let(:followee) { create(:user) }

    before do
      follower.follow(followee)
    end

    it 'destroys the relationship' do
      expect {
        follower.unfollow(followee)
      }.to change(Follow, :count).by(-1)
    end

    it 'destroys the follower_relationship for the follower' do
      follower.unfollow(followee)

      expect(follower.followees).not_to include(followee)
    end

    it 'destroys the followee_relationship for the followee' do
      follower.unfollow(followee)

      expect(followee.followers).not_to include(follower)
    end
  end

end
