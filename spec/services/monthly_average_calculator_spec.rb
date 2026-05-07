require "rails_helper"

RSpec.describe MonthlyAverageCalculator do
  describe ".calculate_for_subject" do
    before do
      5.times do
        create(
          :daily_statistic,
          subject: "Math",
          daily_low: 40,
          daily_high: 90,
          result_count: 50
        )
      end
    end

    it "creates monthly average" do
      expect {
        described_class.calculate_for_subject("Math")
      }.to change(MonthlyAverage, :count).by(1)

      average = MonthlyAverage.last

      expect(average.average_daily_low).to eq(40.0)
      expect(average.average_daily_high).to eq(90.0)
      expect(average.total_result_count).to eq(250)
    end
  end
end
