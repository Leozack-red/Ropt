# frozen_string_literal: true

RSpec.describe Ropt::VectorMatrixMath::OperationVectors do
  subject(:vectors) { described_class.new(first_vector, second_vector).inner_product }

  describe "#inner_product" do
    context "with inner product of integer components of vector_matrix_math" do
      let(:first_vector) { [1, 2] }
      let(:second_vector) { [2, 3] }

      it "will product" do
        expect(vectors).to eq 8
      end
    end

    context "with inner product of integers and floats components of vector_matrix_math" do
      let(:first_vector) { [1.4, 2] }
      let(:second_vector) { [2, 3.9] }

      it "will product" do
        expect(vectors).to eq 10.6
      end
    end
  end
end
