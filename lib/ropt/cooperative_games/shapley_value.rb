# frozen_string_literal: true

module Ropt
  module CooperativeGames
    # class for calculating of Shapley Value something super-additive convex cooperative game
    class ShapleyValue
      attr_accessor :coalitions, :number_players, :coefficients, :round

      DEFAULT_VALUE_OF_COALITION = 0
      def initialize(coalitions, number_players, round = 3)
        @coalitions = coalitions
        @number_players = number_players
        @coefficients = Ropt::CooperativeGames::CoalitionsCoefficients.new(number_players).call
        @round = round
      end

      def solve
        validate_input
        validate_coefficients
        validate_grand_coalition
        vector if validate_vector
      end

      private

      def vector
        vector = (0..number_players - 1).map do |number|
          name_player = singleton_coalitions[number].first
          coalitions_with_player = coalitions_with_player(name_player)

          shapley_value_for_one_player(name_player, coalitions_with_player)
        end

        sum_subarray(vector)
      end

      def shapley_value_for_one_player(name_player, coalitions_with_player)
        coalitions_with_player.map do |coalition, value|
          if coalition.size == 1
            coefficients[0] * value
          else
            coefficients[coalition.size - 1] * (value - value_coalition_without_player(coalition, name_player))
          end
        end.flatten
      end

      def sum_subarray(vector)
        vector.map { |array| array.sum.round(round) }
      end

      def value_coalition_without_player(coalition, name_player)
        value = coalitions[coalition.to_s.delete(name_player.to_s).to_sym]
        return value unless value.nil?

        DEFAULT_VALUE_OF_COALITION
      end

      def singleton_coalitions
        coalitions.select { |key, _value| key.size == 1 }.to_a
      end

      def coalitions_with_player(name_player)
        coalitions.select { |key, _value| key.to_s.include?(name_player.to_s) }
      end

      def validate_coefficients
        raise Error, "Not find coefficients" if coefficients.empty?
      end

      def validate_grand_coalition
        return if value_grand_coalition

        raise Error,
              "Not find grand coalition or no several singletons coalitions is defined"
      end

      def validate_input
        raise Error, "Not find coalitions" if coalitions.nil? || coalitions.empty?
        raise Error, "Not find number of players" if number_players.nil?
      end

      def validate_vector
        if vector.sum.round(2) != value_grand_coalition.round(2)
          raise Error,
                "Sum values of vector_matrix_math is not equal value of grand coalition"
        end

        true
      end

      def value_grand_coalition
        names_singleton_coalitions = singleton_coalitions.map(&:first)
        coalitions[names_singleton_coalitions.join.to_sym]
      end
    end
  end
end
