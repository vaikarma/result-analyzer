FactoryBot.define do
  factory :daily_statistic do
    date { Date.today }
    subject { "Math" }
    daily_low { 40 }
    daily_high { 90 }
    result_count { 50 }
  end
end