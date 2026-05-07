require "rails_helper"

RSpec.describe "TestResults API", type: :request do
  describe "POST /api/v1/test_results" do
    let(:params) do
      {
        student_name: "Vaibhav",
        subject: "Science",
        marks: 88,
        timestamp: Time.current
      }
    end

    it "creates test result" do
      post "/api/v1/test_results", params: params

      expect(response).to have_http_status(:created)
      expect(TestResult.count).to eq(1)
    end
  end
end