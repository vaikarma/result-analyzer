require "rails_helper"

RSpec.describe MonthlyAverageJob, type: :job do
  describe "#perform" do
    it "calls MonthlyAverageCalculator" do
      expect(MonthlyAverageCalculator)
        .to receive(:call)

      described_class.perform_now
    end
  end
end
