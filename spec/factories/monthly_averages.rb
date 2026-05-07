FactoryBot.define do
  factory :monthly_average do
    month { "MyString" }
    subject { "MyString" }
    average_daily_low { 1.5 }
    average_daily_high { 1.5 }
    total_result_count { 1 }
  end
end
