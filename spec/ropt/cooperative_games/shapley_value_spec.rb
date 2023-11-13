# frozen_string_literal: true

RSpec.describe Ropt::CooperativeGames::ShapleyValue do
  subject(:shapley_value) { described_class.new(coalitions, number_players).solve }

  describe "#solve" do
    context "with 3-players game and integers values of costs" do
      let(:number_players) { 3 }
      let(:coalitions) do
        {
          A: 0,
          B: 0,
          C: 0,
          AB: 1,
          AC: 1,
          ABC: 1
        }
      end

      it "return Shapley Value" do
        expect(shapley_value).to contain_exactly((2.0 / 3.0).round(3), (1.0 / 6.0).round(3), (1.0 / 6.0).round(3))
      end
    end

    context "with 3-players game and float values of gain" do
      let(:number_players) { 3 }
      let(:coalitions) do
        {
          a: 0.0,
          b: 0.0,
          c: 0.0,
          ab: 1.0,
          ac: 1.0,
          abc: 1.0
        }
      end

      it "return Shapley Value" do
        expect(shapley_value).to contain_exactly((2.0 / 3.0).round(3), (1.0 / 6.0).round(3), (1.0 / 6.0).round(3))
      end
    end

    context "with 3-players game and integer values of gain" do
      let(:coalitions) do
        {
          a: 5000,
          b: 5000,
          c: 0,
          ab: 7500,
          ac: 7500,
          bc: 5000,
          abc: 10_000
        }
      end

      context "with more then 10 gain" do
        let(:number_players) { 3 }

        it "return Shapley Value" do
          expect(shapley_value).to contain_exactly(5000, 3750, 1250)
        end
      end

      context "with missing of number of players will return error" do
        let(:number_players) { nil }

        it "raise exception" do
          expect { shapley_value }.to raise_error(Ropt::Error)
        end
      end
    end

    context "with 3-players game and very small gains" do
      subject(:shapley_value) { described_class.new(coalitions, number_players, round).solve }

      let(:number_players) { 3 }
      let(:coalitions) do
        {
          a: 0.00234,
          b: 0.2341,
          c: 0.000001234,
          ab: 0.753,
          ac: 0.107539,
          bc: 0.3453400345,
          abc: 1.957650912873
        }
      end
      let(:round) { 7 }

      it "return Shapley Value" do
        expect(shapley_value).to contain_exactly(0.4376239, 0.6426233, 0.8774038)
      end
    end

    context "with missing of coalitions of players will return error" do
      let(:number_players) { 3 }
      let(:coalitions) { nil }

      it "raise exception" do
        expect { shapley_value }.to raise_error(Ropt::Error)
      end
    end
  end
end
