require "rails_helper"

RSpec.describe TestResult, type: :model do
  it { is_expected.to validate_presence_of(:student_name) }
  it { is_expected.to validate_presence_of(:subject) }
  it { is_expected.to validate_presence_of(:marks) }
  it { is_expected.to validate_presence_of(:submitted_at) }

  it do
    is_expected.to validate_numericality_of(:marks)
      .only_integer
      .is_greater_than_or_equal_to(0)
      .is_less_than_or_equal_to(100)
  end
end
