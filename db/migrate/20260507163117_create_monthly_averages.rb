class CreateMonthlyAverages < ActiveRecord::Migration[8.1]
  def change
    create_table :monthly_averages do |t|
      t.string :month
      t.string :subject
      t.float :average_daily_low
      t.float :average_daily_high
      t.integer :total_result_count

      t.timestamps
    end
  end
end
