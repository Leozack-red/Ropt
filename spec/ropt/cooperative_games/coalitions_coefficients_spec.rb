# frozen_string_literal: true

RSpec.describe Ropt::CooperativeGames::CoalitionsCoefficients do
  subject(:coefficients) { described_class.new(number_players).call }

  describe "#call" do
    context "with 3 number players" do
      let(:number_players) { 3 }

      it "return array of coefficients for coalitions" do
        expect(coefficients).to contain_exactly(1.0 / 3.0, 1.0 / 6.0, 1.0 / 3.0)
      end
    end

    context "with 4 number players" do
      let(:number_players) { 4 }

      it "return array of coefficients for coalitions" do
        expect(coefficients).to contain_exactly(1.0 / 4.0, 1.0 / 12.0, 1.0 / 12.0, 1.0 / 4.0)
      end
    end

    context "with limit value" do
      let(:number_players) { Ropt::CooperativeGames::CoalitionsCoefficients::LIMIT_VALUE }

      it "raise exception" do
        expect { coefficients }.to raise_error(Ropt::Error)
      end
    end
  end
end
