# frozen_string_literal: true

module Ropt
  module CooperativeGames
    # class for validation after and before calculating vector shapley
    class Validator
      def validate_arguments(coefficients, coalitions, number_gamers)
        validate_coefficients(coefficients)
        validate_coalitions(coalitions)
        validate_number_gamers(number_gamers)
      end

      def validate_coalitions_consistency(coalitions, names_singletons)
        validate_consistency(coalitions, names_singletons)
      end

      def validate_result(coalitions, names_singletons, vector)
        value_grand_coalition = value_grand_coalition(coalitions, names_singletons)
        validate_vector(value_grand_coalition, vector)
      end

      private

      def validate_coefficients(coefficients)
        raise Error, "Not find coefficients" if coefficients.empty? || coefficients.nil?
      end

      def validate_coalitions(coalitions)
        raise Error, "Not find coalitions" if coalitions.nil? || coalitions.empty?
      end

      def validate_number_gamers(number_gamers)
        raise Error, "Not find number of gamers" if number_gamers.nil?
      end

      def validate_consistency(coalitions, names_singletons)
        value_grand_coalition = value_grand_coalition(coalitions, names_singletons)
        validate_value_grand_coalition(value_grand_coalition)

        return unless Set.new(names_singletons) == Set.new(coalitions.keys.max.to_s.chars)

        raise Error, "Not find gamer in grand coalition or singleton coalition"
      end

      def value_grand_coalition(coalitions, names_singletons)
        coalitions.select { |coalition| coalition.size == names_singletons.count }.values.first
      end

      def validate_value_grand_coalition(value)
        return if value

        raise Error,
              "Not find value of grand coalition or no several singletons coalitions is defined"
      end

      def validate_vector(value_grand_coalition, vector)
        return if vector.values.sum.round(2) == value_grand_coalition.to_f.round(2)

        raise Error,
              "Sum values of vector_matrix_math is not equal value of grand coalition"
      end
    end
  end
end
