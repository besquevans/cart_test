require 'rails_helper'

RSpec.describe Stock, type: :model do
  context "association" do
    it "product has stock" do
      product = create(:product)

      expect(product.stock.amount).to eq(10)
    end
  end

  context "amount" do
    it "stock should more than 0" do
      product = create(:product)
      product.stock.update(amount: -1)

      expect(product.stock).to_not be_valid
    end
  end
end
