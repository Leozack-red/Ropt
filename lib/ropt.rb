# frozen_string_literal: true

require_relative "ropt/version"

# module for integrate all solvers of optimization problems
module Ropt
  class Error < StandardError; end

  require_relative "ropt/vector_matrix_math/operation_vectors"
  require_relative "ropt/antagonistic_games/matrix_game"
  require_relative "ropt/cooperative_games/coalitions_coefficients"
  require_relative "ropt/cooperative_games/shapley_value"
  require_relative "ropt/cooperative_games/validator"
end
