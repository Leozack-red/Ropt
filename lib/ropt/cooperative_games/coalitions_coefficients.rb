# frozen_string_literal: true

module Ropt
  module CooperativeGames
    # class for get coefficients of Shapley Value with limit of number of gamers equal 171
    class CoalitionsCoefficients
      attr_accessor :number_gamers

      LIMIT_VALUE = 171

      def initialize(number_gamers)
        @number_gamers = number_gamers.to_f
      end

      def call
        validate_number
        coefficients if number_gamers == coefficients.size
      end

      private

      def coefficients
        (0...number_gamers).map do |coalition_power|
          numerator = factorial(coalition_power) * factorial(number_gamers - coalition_power - 1)
          numerator.to_f / factorial(number_gamers)
        end
      end

      def factorial(number)
        (1..number).inject(1, :*)
      end

      def validate_number
        return unless number_gamers >= LIMIT_VALUE

        raise Error,
              "The gamers is #{LIMIT_VALUE} or more. You should reduce the number of gamers"
      end
    end
  end
end
