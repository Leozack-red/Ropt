# frozen_string_literal: true

require "matrix"
require "ropt/vector_matrix_math/shell_vector"

module Ropt
  module VectorMatrixMath
    # class-wrapper for converting arrays to objects of vectors with option of inner product
    class OperationVectors
      attr_accessor :vector1, :vector2

      def initialize(vector1, vector2)
        @vector1 = ShellVector.create(vector1)
        @vector2 = ShellVector.create(vector2)
      end

      def inner_product
        vector1.inner_product(vector2)
      end
    end
  end
end
