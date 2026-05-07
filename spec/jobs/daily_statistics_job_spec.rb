require "rails_helper"

RSpec.describe DailyStatisticsJob, type: :job do
  describe "#perform" do
    it "calls DailyStatisticsCalculator" do
      expect(DailyStatisticsCalculator)
        .to receive(:call)

      described_class.perform_now
    end
  end
end
