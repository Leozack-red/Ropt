# frozen_string_literal: true

RSpec.describe Ropt::AntagonisticGames::MatrixGame do
  subject(:matrix_game) { described_class.new(strategies) }

  let(:strategies) { [[0, 23, 2, 423, 34, 4, 2], [55, 7, 10, 13, 434, 3434, 34], [5, 7, 10, 3, 44, 334, 34]] }

  describe "#result" do
    context "with strategies and no report" do
      let(:result) { matrix_game.result }

      it "contains calculations first strategy" do
        expect(result[:first_strategy]).to match_array strategies[1]
      end

      it "contains calculations second strategy" do
        expect(result[:second_strategy]).to contain_exactly(2, 10, 10)
      end

      it "contains calculations lower value" do
        expect(result[:lower_value]).to eq 7
      end

      it "contains calculations higher value" do
        expect(result[:higher_value]).to eq 10
      end

      it "contains calculations the disequilibrium" do
        expect(result[:equilibrium]).to be_falsy
      end
    end

    context "with strategies for equilibrium and no report" do
      let(:result) { matrix_game.result }

      let(:strategies) { [[2, 1], [2, 0]] }

      it "contains calculations first strategy" do
        expect(result[:first_strategy]).to match_array strategies[0]
      end

      it "contains calculations second strategy" do
        expect(result[:second_strategy]).to contain_exactly(1, 0)
      end

      it "contains calculations lower value" do
        expect(result[:lower_value]).to eq 1
      end

      it "contains calculations higher value" do
        expect(result[:higher_value]).to eq 1
      end

      it "contains calculations the equilibrium" do
        expect(result[:equilibrium]).to be_truthy
      end
    end

    context "with strategies and report" do
      let(:result) { matrix_game.result(report: true) }

      it "contains calculations optimal strategies and string report message" do
        expect(result).to be_a(String)
      end
    end
  end
end
