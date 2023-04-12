require 'rails_helper'

RSpec.describe "Api::V1::Clocks", type: :request do
  describe "GET #index" do
    let(:user) { create(:user) }
    let!(:clocks) { create_list(:clock, 3, user: user) }

    context "when user is authenticated" do
      it "returns all clocks ordered by created_at" do
        expected_result = clocks.sort_by(&:created_at)
        expect(clocks).to eq(expected_result)
      end
    end
  end

  describe "POST #create" do
    context "when user is authenticated" do
      let(:user) { create(:user) }
      let(:clocks) { Clock.new(clock_in_time: Time.now, clock_out_time: Time.now + 4.hours, user: user) }

      it "creates a new clock record" do
        expect(clocks).to be_valid
      end

      it "does not create a new clock record with invalid params" do
        clocks.clock_in_time = nil
        expect {
          clocks
        }.to_not change(Clock, :count)
      end
    end
  end
end
