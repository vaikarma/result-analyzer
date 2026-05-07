# Result Analyzer (Rails API)

This application processes student test results received from a third-party system (MSM), stores them, and performs daily and monthly analytics using background jobs.

---

## Tech Stack

- Ruby 3.4.9
- Rails 8.1.3 (API mode)
- PostgreSQL
- Sidekiq
- sidekiq-cron
- RSpec

---

## What this project does

Students take online tests and results are pushed into this system via an API.

The system:

- Stores all incoming test results
- Calculates daily statistics every evening
- Calculates monthly averages based on a specific business rule

---

## API

### Create Test Result

`POST /api/v1/test_results`

Example request:

```json
{
  "student_name": "Vaibhav",
  "subject": "Math",
  "marks": 85,
  "timestamp": "2026-05-07T10:00:00Z"
}
```

Response:

```json
{
  "message": "Result stored successfully"
}
```

---

## Daily Statistics (EOD Job)

Runs every day at 6:00 PM.

For each subject, it calculates:

- Lowest marks for the day
- Highest marks for the day
- Total number of results

This data is stored in `daily_statistics`.

---

## Monthly Average Logic

This runs only on a specific condition:

- Monday of the week containing the third Wednesday of the month

### How it works:

- Start from last 5 days of daily statistics
- If total results are less than 200, go further back in time
- Keep adding days until total results reach at least 200
- Then calculate:
  - Average of daily highs
  - Average of daily lows
  - Total number of results used

Store result in `monthly_averages`.

---

## Background Jobs

- DailyStatisticsJob → runs daily at 6 PM
- MonthlyAverageJob → runs on the required Monday

Scheduling is handled using sidekiq-cron.

---

## Architecture

- Controller → handles API requests
- Service layer → contains business logic
- Models → persist data
- Jobs → run scheduled processing

---

## Testing

This project is written using TDD approach.

Test coverage includes:

- Model validations
- API requests
- Service logic
- Job execution
- Edge cases

### Run tests

```bash
bundle exec rspec
```

---

## Setup

```bash
git clone <repo-url>
cd result_analyzer
bundle install
rails db:create
rails db:migrate
```

Run server:

```bash
rails s
```

Run Sidekiq:

```bash
bundle exec sidekiq
```

---

## Design Notes

- Service objects are used to keep business logic separate
- Jobs are made idempotent to avoid duplicate data
- Database constraints are added for data integrity
- Everything is built with test-first approach (TDD)

---

## Assumptions

- Marks are always between 0–100
- MSM sends valid timestamp format
- System timezone is consistent
- Jobs run once per schedule without overlap

---

## Future Improvements

- Add authentication (JWT or Devise Token Auth)
- Add rate limiting for API
- Add admin dashboard for analytics
- Improve performance for large datasets