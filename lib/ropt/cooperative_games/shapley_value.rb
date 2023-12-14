# frozen_string_literal: true

module Ropt
  module CooperativeGames
    # class for calculating of Shapley Value something super-additive convex cooperative game
    class ShapleyValue
      attr_accessor :coalitions, :number_gamers, :coefficients, :validator, :round

      DEFAULT_VALUE_OF_COALITION = 0
      def initialize(coalitions, number_gamers, round = 3)
        @coalitions = coalitions
        @number_gamers = number_gamers
        @coefficients = Ropt::CooperativeGames::CoalitionsCoefficients.new(number_gamers).call
        @validator = Ropt::CooperativeGames::Validator.new
        @round = round
      end

      def solve
        validator.validate_arguments(coefficients,
                                     coalitions,
                                     number_gamers)

        singletons = singleton_coalitions

        validator.validate_coalitions_consistency(coalitions, singletons.keys)

        vector = calculate_vector_shapley(singletons)

        validator.validate_result(coalitions, singletons.keys, vector)

        vector
      end

      private

      def singleton_coalitions
        coalitions.select { |key, _value| key.size == 1 }
      end

      def calculate_vector_shapley(singletons)
        vector = singletons.each_with_object({}) do |singleton, result|
          name_gamer = singleton.first
          coalitions_with_gamer = coalitions_with_gamer(name_gamer)

          result.merge!(shapley_value_for_one_gamer(name_gamer, coalitions_with_gamer))
        end

        aggregate_components(vector)
      end

      def shapley_value_for_one_gamer(name_gamer, coalitions_with_gamer)
        cost_gamer = coalitions_with_gamer.flat_map do |coalition, value|
          if coalition.size == 1
            coefficients[0] * value
          else
            coefficients[coalition.size - 1] * (value - value_coalition_without_gamer(coalition, name_gamer))
          end
        end

        { name_gamer => cost_gamer }
      end

      def aggregate_components(vector)
        vector.transform_values { |component| component.sum.round(round) }
      end

      def value_coalition_without_gamer(coalition, name_gamer)
        value = coalitions[coalition.to_s.delete(name_gamer.to_s).to_sym]
        return value unless value.nil?

        DEFAULT_VALUE_OF_COALITION
      end

      def coalitions_with_gamer(name_gamer)
        coalitions.select { |key, _value| key.to_s.include?(name_gamer.to_s) }
      end
    end
  end
end
