# frozen_string_literal: true

require "matrix"

module Ropt
  module VectorMatrixMath
    # class-wrapper for converting vectors objects to matrix
    class ShellMatrix
      def self.create(rows)
        Matrix.send(:new, rows)
      end
    end
  end
end
