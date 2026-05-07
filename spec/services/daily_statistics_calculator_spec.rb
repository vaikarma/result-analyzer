require "rails_helper"

RSpec.describe DailyStatisticsCalculator do
  describe ".call" do
    it "creates daily statistics" do
      create(:test_result, subject: "Math", marks: 40)
      create(:test_result, subject: "Math", marks: 90)

      expect {
        described_class.call(Date.today)
      }.to change(DailyStatistic, :count).by(1)

      stat = DailyStatistic.last

      expect(stat.daily_low).to eq(40)
      expect(stat.daily_high).to eq(90)
      expect(stat.result_count).to eq(2)
    end
  end
end
