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

    it "creates test result from JSON payload" do
      post "/api/v1/test_results",
           params: params.to_json,
           headers: { "CONTENT_TYPE" => "application/json" }

      expect(response).to have_http_status(:created)
      expect(TestResult.count).to eq(1)
    end

    it "returns 422 when required fields are missing" do
      post "/api/v1/test_results",
           params: { student_name: "Vaibhav" }.to_json,
           headers: { "CONTENT_TYPE" => "application/json" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(TestResult.count).to eq(0)
    end
  end
end