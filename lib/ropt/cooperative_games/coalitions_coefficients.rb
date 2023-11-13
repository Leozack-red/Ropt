# frozen_string_literal: true

module Ropt
  module CooperativeGames
    # class for get coefficients of Shapley Value with limit of number of players equal 171
    class CoalitionsCoefficients
      attr_accessor :number_players

      LIMIT_VALUE = 171

      def initialize(number_players)
        @number_players = number_players.to_f
      end

      def call
        validate_number
        coefficients if number_players == coefficients.size
      end

      private

      def coefficients
        (0...number_players).map do |coalition_power|
          numerator = factorial(coalition_power) * factorial(number_players - coalition_power - 1)
          numerator.to_f / factorial(number_players)
        end
      end

      def factorial(number)
        (1..number).inject(1, :*)
      end

      def validate_number
        return unless number_players >= LIMIT_VALUE

        raise Error,
              "The players is #{LIMIT_VALUE} or more. You should reduce the number of players"
      end
    end
  end
end
