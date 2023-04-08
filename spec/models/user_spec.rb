require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Bob Marle') }

  describe "associations" do
    it { should have_many(:following_users) }
    it { should have_many(:followed_users) }
    it { should have_many(:followers).through(:following_users) }
    it { should have_many(:followees).through(:followed_users) }
  end

  context "with valid attributes" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end

  context "with invalid attributes" do
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

end
