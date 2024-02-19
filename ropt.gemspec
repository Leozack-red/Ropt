# frozen_string_literal: true

require_relative "lib/ropt/version"

Gem::Specification.new do |spec|
  spec.name = "ropt"
  spec.version = Ropt::VERSION
  spec.authors = ["Lev Pruglo "]
  spec.email = ["lev.pruglo@mail.ru"]

  spec.summary = "Library for mathematical optimization"
  spec.description = "The library for mathematical optimization in Ruby is designed to help solve many problems in the
                      computational, financial, social, and energy fields and, in theory,
                      should include components of game theory, combinatorics, probability theory,
                      linear and nonlinear optimization, cluster, regression, and other analysis."
  spec.homepage = "https://github.com/Leozack-red"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Leozack-red/ropt"
  spec.metadata["changelog_uri"] = "https://github.com/Leozack-red/ropt/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extra_rdoc_files = ["README.md"]

  spec.add_dependency "matrix"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
