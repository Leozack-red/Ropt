# frozen_string_literal: true

require "matrix"

module Ropt
  module VectorMatrixMath
    # class-wrapper for converting numerics objects to vector
    class ShellVector < Vector
      def self.create(components_vector)
        Vector.send(:new, components_vector)
      end
    end
  end
end
