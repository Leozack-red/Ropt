# frozen_string_literal: true

module Ropt
  module CooperativeGames
    # class for validation after and before calculating vector shapley
    class Validator
      def validate_arguments(coefficients, coalitions, number_gamers)
        validate_number_gamers(number_gamers)
        validate_coalitions(coalitions)
        validate_coefficients(coefficients)
      end

      def validate_coalitions_consistency(coalitions, names_singletons)
        value_grand_coalition = value_grand_coalition(coalitions, names_singletons)
        validate_value_grand_coalition(value_grand_coalition)
      end

      def validate_result(coalitions, names_singletons, vector)
        value_grand_coalition = value_grand_coalition(coalitions, names_singletons)
        validate_vector(value_grand_coalition, vector)
      end

      private

      def validate_coefficients(coefficients)
        raise Error, "Not find coefficients" if coefficients.nil? || coefficients.empty?
      end

      def validate_coalitions(coalitions)
        raise Error, "Not find coalitions" if coalitions.nil? || coalitions.empty?
      end

      def validate_number_gamers(number_gamers)
        raise Error, "Not find number of gamers" if number_gamers.nil?
      end

      def value_grand_coalition(coalitions, names_singletons)
        most_big_coalition = coalitions.keys.max_by(&:length)
        most_big_coalition_by_singles = coalitions.select do |coalition|
          coalition.size == names_singletons.count
        end

        return nil if most_big_coalition != most_big_coalition_by_singles.keys.first

        most_big_coalition_by_singles.values.first
      end

      def validate_value_grand_coalition(value)
        return if value

        raise Error,
              "Not find value of grand coalition or several singletons coalitions"
      end

      def validate_vector(value_grand_coalition, vector)
        return if vector.values.sum.round(2) == value_grand_coalition.to_f.round(2)

        raise Error,
              "Sum components of Shapley vector is not equal value of grand coalition"
      end
    end
  end
end
