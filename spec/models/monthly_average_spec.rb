require "rails_helper"

RSpec.describe MonthlyAverage, type: :model do
  it "is valid with valid attributes" do
    monthly_average = described_class.new(
      month: "2026-05",
      subject: "Math",
      average_daily_low: 45.5,
      average_daily_high: 88.2,
      total_result_count: 250
    )

    expect(monthly_average).to be_valid
  end

  it "is invalid without month" do
    monthly_average = described_class.new(
      subject: "Math"
    )

    expect(monthly_average).not_to be_valid
  end

  it "is invalid without subject" do
    monthly_average = described_class.new(
      month: "2026-05"
    )

    expect(monthly_average).not_to be_valid
  end
end
