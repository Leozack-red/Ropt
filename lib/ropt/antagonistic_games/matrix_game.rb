# frozen_string_literal: true

require "ropt/vector_matrix_math/shell_matrix"

module Ropt
  module AntagonisticGames
    # class for matrix game solver with option of get report string message
    class MatrixGame
      attr_accessor :matrix, :count_rows, :count_columns

      def initialize(rows)
        @matrix = Ropt::VectorMatrixMath::ShellMatrix.create(rows)
        @count_rows = rows.size
        @count_columns = rows.first.size
      end

      def solve
        hash_result
      end

      private

      def hash_result
        {
          first_gamer_optimal_strategy: opt_strategy(:first),
          second_gamer_optimal_strategy: opt_strategy(:second),
          lower_value:,
          higher_value:,
          equilibrium: lower_value == higher_value
        }
      end

      def opt_strategy(gamer_position)
        case gamer_position
        when :first
          index = find_vector(:row).index(lower_value)
          matrix.row(index).to_a
        when :second
          index = find_vector(:column).index(higher_value)
          matrix.column(index).to_a
        end
      end

      def lower_value
        find_vector(:row).max
      end

      def higher_value
        find_vector(:column).min
      end

      def find_vector(vector)
        case vector
        when :row
          (0...count_rows).map { |number| find_extremum(number, :min) }
        when :column
          (0...count_columns).map { |number| find_extremum(number, :max) }
        end
      end

      def find_extremum(number, direction)
        case direction
        when :min then matrix.row(number).min
        when :max then matrix.column(number).max
        end
      end
    end
  end
end
