require "rails_helper"

RSpec.describe DailyStatistic, type: :model do
  it "is valid with valid attributes" do
    daily_statistic = described_class.new(
      date: Date.today,
      subject: "Math",
      daily_low: 40,
      daily_high: 90,
      result_count: 20
    )

    expect(daily_statistic).to be_valid
  end

  it "is invalid without date" do
    daily_statistic = described_class.new(
      subject: "Math"
    )

    expect(daily_statistic).not_to be_valid
  end

  it "is invalid without subject" do
    daily_statistic = described_class.new(
      date: Date.today
    )

    expect(daily_statistic).not_to be_valid
  end
end
