require "rails_helper"

RSpec.describe TestResult, type: :model do
  it "is valid with valid attributes" do
    expect(build(:test_result)).to be_valid
  end

  it "is invalid without student_name" do
    result = build(:test_result, student_name: nil)

    expect(result).not_to be_valid
  end
end
