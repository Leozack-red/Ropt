# frozen_string_literal: true

RSpec.describe Ropt::AntagonisticGames::MatrixGame do
  subject(:matrix_game) { described_class.new(strategies) }

  let(:strategies) { [[0, 23, 2, 423, 34, 4, 2], [55, 7, 10, 13, 434, 3434, 34], [5, 7, 10, 3, 44, 334, 34]] }

  describe "#solve" do
    let(:result) { matrix_game.solve }

    context "when game without equilibrium" do
      it "returns first gamer optimal strategy" do
        expect(result[:first_gamer_optimal_strategy]).to match_array strategies[1]
      end

      it "returns second gamer optimal strategy" do
        expect(result[:second_gamer_optimal_strategy]).to contain_exactly(2, 10, 10)
      end

      it "returns lower value" do
        expect(result[:lower_value]).to eq 7
      end

      it "returns higher value" do
        expect(result[:higher_value]).to eq 10
      end

      it "returns the disequilibrium" do
        expect(result[:equilibrium]).to be_falsy
      end
    end

    context "when game with equilibrium" do
      let(:strategies) { [[2, 1], [2, 0]] }

      it "returns first gamer optimal strategy" do
        expect(result[:first_gamer_optimal_strategy]).to match_array strategies[0]
      end

      it "returns second gamer optimal strategy" do
        expect(result[:second_gamer_optimal_strategy]).to contain_exactly(1, 0)
      end

      it "returns lower value" do
        expect(result[:lower_value]).to eq 1
      end

      it "returns higher value" do
        expect(result[:higher_value]).to eq 1
      end

      it "returns the equilibrium" do
        expect(result[:equilibrium]).to be_truthy
      end
    end
  end
end
