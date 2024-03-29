# frozen_string_literal: true

RSpec.describe Ropt::CooperativeGames::ShapleyValue do
  subject(:shapley_value) { described_class.new(coalitions, number_gamers).solve }

  describe "#solve" do
    context "when 3-gamers game" do
      let(:number_gamers) { 3 }

      context "with integers values of costs" do
        let(:coalitions) do
          {
            B: 0,
            A: 0,
            AB: 1,
            C: 0,
            ABC: 1,
            AC: 1
          }
        end

        it "return Shapley Value" do
          expect(shapley_value).to eq(A: (2.0 / 3.0).round(3),
                                      B: (1.0 / 6.0).round(3),
                                      C: (1.0 / 6.0).round(3))
        end
      end

      context "with float values of gain" do
        let(:number_gamers) { 3 }
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
          expect(shapley_value).to eq(a: (2.0 / 3.0).round(3),
                                      b: (1.0 / 6.0).round(3),
                                      c: (1.0 / 6.0).round(3))
        end
      end

      context "with integer values of gain" do
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
          it "return Shapley Value" do
            expect(shapley_value).to eq(a: 5000, b: 3750, c: 1250)
          end
        end
      end

      context "with very small gains" do
        subject(:shapley_value) { described_class.new(coalitions, number_gamers, round).solve }

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
          expect(shapley_value).to eq(c: 0.4376239, a: 0.6426233, b: 0.8774038)
        end
      end

      context "with missing of coalitions of gamers" do
        let(:number_gamers) { 3 }
        let(:coalitions) { nil }

        it "raise exception" do
          expect { shapley_value }.to raise_error(Ropt::Error, "Not find coalitions")
        end
      end
    end

    context "when missing of number of gamers" do
      let(:number_gamers) { nil }
      let(:coalitions) do
        {
          B: 0,
          A: 0,
          AB: 1,
          C: 0,
          ABC: 1,
          AC: 1
        }
      end

      it "raise exception" do
        expect { shapley_value }.to raise_error(Ropt::Error, "Not find number of gamers")
      end
    end

    context "when missing coefficients" do
      let(:coalitions) do
        {
          B: 0,
          A: 0,
          AB: 1,
          C: 0,
          ABC: 1,
          AC: 1
        }
      end
      let(:number_gamers) { 3 }

      before do
        double = instance_double(
          Ropt::CooperativeGames::CoalitionsCoefficients,
          call: nil
        )
        allow(
          Ropt::CooperativeGames::CoalitionsCoefficients
        )
          .to receive(:new)
          .with(number_gamers)
          .and_return(double)
      end

      it "raise exception" do
        expect { shapley_value }.to raise_error(Ropt::Error, "Not find coefficients")
      end
    end

    context "when not consistency grand coalition" do
      context "with value grand coalition as nil" do
        let(:coalitions) do
          {
            B: 0,
            A: 0,
            AB: 1,
            C: 0,
            ABC: nil,
            AC: 1
          }
        end
        let(:number_gamers) { 3 }

        it "raise exception" do
          expect { shapley_value }.to raise_error(
            Ropt::Error,
            "Not find value of grand coalition or several singletons coalitions"
          )
        end
      end

      context "without one singleton coalition" do
        let(:coalitions) do
          {
            B: 0,
            AB: 1,
            C: 0,
            ABC: 2,
            AC: 1
          }
        end
        let(:number_gamers) { 3 }

        it "raise exception" do
          expect { shapley_value }.to raise_error(
            Ropt::Error,
            "Not find value of grand coalition or several singletons coalitions"
          )
        end
      end
    end
  end
end
