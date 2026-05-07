require "rails_helper"

RSpec.describe DailyStatistic, type: :model do
  subject(:daily_statistic) { build(:daily_statistic) }

  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:subject) }

  it "validates uniqueness of subject scoped to date" do
    create(:daily_statistic, date: daily_statistic.date, subject: daily_statistic.subject)

    expect(daily_statistic).to validate_uniqueness_of(:subject).scoped_to(:date)
  end
end
