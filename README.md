# Ropt

The library for mathematical optimization in Ruby is designed to help solve many problems in the computational, financial, social, and energy fields and, in theory, should include components of game theory, combinatorics, probability theory, linear and nonlinear optimization, cluster, regression, and other analysis.

At the moment, it is a simple library for working with some types of [Antagonistic](https://en.wikipedia.org/wiki/Zero-sum_game) and [Cooperative](https://en.wikipedia.org/wiki/Cooperative_game_theory) Games described in game theory.
Solvers have been written to calculate the lower and upper values of the [Matrix Game](https://en.wikipedia.org/wiki/Normal-form_game), indicating whether there is a Nash equilibrium.
A solver for calculating the [Shapley Vector](https://en.wikipedia.org/wiki/Shapley_value) has been implemented for the cooperative part of game theory.

## Installation

Adding to a gem:

`gem install ropt`

Or adding to your project:

`gem "ropt", "~> 1.0"`

Run bundle install: 

`bundle install`

## Usage

To call the matrix game solver, you need to do:

```
strategies = [[2, 1], [2, 0]]
Ropt::AntagonisticGames::MatrixGame.new(strategies).solve
```

In this example, the result will be:
```
{
   :first_gamer_optimal_strategy=>[2, 1], 
   :second_gamer_optimal_strategy=>[1, 0], 
   :lower_value=>1, 
   :higher_value=>1, 
   :equilibrium=>true
}
```

For large arrays, there may be a memory limit, which leads to a slowdown in the operation of the method.

Consider an example using a solver to calculate the Shapley Vector. 

The call looks like this:
```
coalitions = {
               B: 0,
               A: 0,
               AB: 1,
               C: 0,
               ABC: 1,
               AC: 1 
              }
               
number_gamers = 3

Ropt::CooperativeGames::ShapleyValue.new(coalitions, number_gamers).solve
```

In this example, the result of Shapley Value will be:

```
{
   :B=>0.167, 
   :A=>0.667, 
   :C=>0.167
}
```
It is worth noting that coalitions and the number of gamers must be sent, otherwise a validation error will occur.
If it is determined that the value of the grand coalition characteristic function is not equal to the sum of the components of the Shapley Vector, the solver will raise an exception.

The constant defines an upper limit for the number of gamers, which is 171 gamers. Exceeding this number will result in an exception being raised.
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Leozack-red/ropt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ropt/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ropt project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ropt/blob/main/CODE_OF_CONDUCT.md).
