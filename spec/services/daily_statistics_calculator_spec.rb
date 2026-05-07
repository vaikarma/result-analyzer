require "rails_helper"

RSpec.describe DailyStatisticsCalculator do
  describe ".call" do
    it "creates daily statistics per subject for the given date" do
      date = Date.new(2026, 5, 7)
      create(:test_result, subject: "Math", marks: 40, submitted_at: date.noon)
      create(:test_result, subject: "Math", marks: 90, submitted_at: date.noon)
      create(:test_result, subject: "Science", marks: 70, submitted_at: date.noon)
      create(:test_result, subject: "Science", marks: 10, submitted_at: date.noon)

      expect {
        described_class.call(date)
      }.to change(DailyStatistic, :count).by(2)

      math = DailyStatistic.find_by!(subject: "Math", date: date)
      science = DailyStatistic.find_by!(subject: "Science", date: date)

      expect(math.daily_low).to eq(40)
      expect(math.daily_high).to eq(90)
      expect(math.result_count).to eq(2)

      expect(science.daily_low).to eq(10)
      expect(science.daily_high).to eq(70)
      expect(science.result_count).to eq(2)
    end

    it "only aggregates results within the specified day" do
      date = Date.new(2026, 5, 7)
      create(:test_result, subject: "Math", marks: 50, submitted_at: date.noon)
      create(:test_result, subject: "Math", marks: 99, submitted_at: date.next_day.noon)

      described_class.call(date)

      stat = DailyStatistic.find_by!(subject: "Math", date: date)
      expect(stat.daily_low).to eq(50)
      expect(stat.daily_high).to eq(50)
      expect(stat.result_count).to eq(1)
    end

    it "is idempotent for the same day/subject" do
      date = Date.new(2026, 5, 7)
      create(:test_result, subject: "Math", marks: 50, submitted_at: date.noon)
      create(:test_result, subject: "Math", marks: 80, submitted_at: date.noon)

      expect {
        described_class.call(date)
        described_class.call(date)
      }.to change(DailyStatistic, :count).by(1)

      stat = DailyStatistic.find_by!(subject: "Math", date: date)
      expect(stat.daily_low).to eq(50)
      expect(stat.daily_high).to eq(80)
      expect(stat.result_count).to eq(2)
    end
  end
end
