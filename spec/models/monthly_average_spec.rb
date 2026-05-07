require "rails_helper"

RSpec.describe MonthlyAverage, type: :model do
  subject(:monthly_average) { build(:monthly_average, month: "2026-05", subject: "Math") }

  it { is_expected.to validate_presence_of(:month) }
  it { is_expected.to validate_presence_of(:subject) }

  it "validates uniqueness of subject scoped to month" do
    create(:monthly_average, month: monthly_average.month, subject: monthly_average.subject)

    expect(monthly_average).to validate_uniqueness_of(:subject).scoped_to(:month)
  end
end
