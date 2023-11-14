# frozen_string_literal: true

RSpec.describe Ropt::CooperativeGames::CoalitionsCoefficients do
  subject(:coefficients) { described_class.new(number_gamers).call }

  describe "#call" do
    context "with 3 number gamers" do
      let(:number_gamers) { 3 }

      it "return array of coefficients for coalitions" do
        expect(coefficients).to contain_exactly(1.0 / 3.0, 1.0 / 6.0, 1.0 / 3.0)
      end
    end

    context "with 4 number gamers" do
      let(:number_gamers) { 4 }

      it "return array of coefficients for coalitions" do
        expect(coefficients).to contain_exactly(1.0 / 4.0, 1.0 / 12.0, 1.0 / 12.0, 1.0 / 4.0)
      end
    end

    context "with limit value" do
      let(:number_gamers) { Ropt::CooperativeGames::CoalitionsCoefficients::LIMIT_VALUE }

      it "raise exception" do
        expect { coefficients }.to raise_error(Ropt::Error)
      end
    end
  end
end
