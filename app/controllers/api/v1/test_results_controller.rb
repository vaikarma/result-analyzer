module Api
  module V1
    class TestResultsController < ApplicationController
      def create
        test_result = TestResult.new(test_result_params)

        if test_result.save
          render json: { message: "Result stored successfully" }, status: :created
        else
          render json: { errors: test_result.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def test_result_params
        permitted = params.permit(:student_name, :subject, :marks, :timestamp)

        {
          student_name: permitted[:student_name],
          subject: permitted[:subject],
          marks: permitted[:marks],
          submitted_at: permitted[:timestamp]
        }
      end
    end
  end
end
