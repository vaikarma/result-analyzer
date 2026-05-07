class AddConstraintsAndIndexes < ActiveRecord::Migration[8.1]
  def change
    change_column_null :test_results, :student_name, false
    change_column_null :test_results, :subject, false
    change_column_null :test_results, :marks, false
    change_column_null :test_results, :submitted_at, false

    change_column_null :daily_statistics, :date, false
    change_column_null :daily_statistics, :subject, false
    change_column_null :daily_statistics, :daily_low, false
    change_column_null :daily_statistics, :daily_high, false
    change_column_null :daily_statistics, :result_count, false

    change_column_null :monthly_averages, :month, false
    change_column_null :monthly_averages, :subject, false
    change_column_null :monthly_averages, :average_daily_low, false
    change_column_null :monthly_averages, :average_daily_high, false
    change_column_null :monthly_averages, :total_result_count, false

    add_index :test_results, [ :submitted_at, :subject ]
    add_index :daily_statistics, [ :date, :subject ], unique: true
    add_index :monthly_averages, [ :month, :subject ], unique: true
  end
end

