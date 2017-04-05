require 'rails_helper'

RSpec.describe Sale, type: :model do
  it "should require an item_id" do
    sale = Sale.new({ merchant_id: 1 })
    expect(sale.valid?).to be(false)
  end

  it "should require a merchant_id" do
    sale = Sale.new({ item_id: 1 })
    expect(sale.valid?).to be(false)
  end

  it "should treat all sales as individual transactions" do
    sale1 = Sale.new({ item_id: 1, merchant_id: 1})
    expect(sale1.valid?).to be(true)
    sale1.save!

    sale2 = Sale.new({ item_id: 1, merchant_id: 1 })
    expect(sale2.valid?).to be(true)
    expect { sale1.save! }.not_to raise_error(Exception)
    expect(sale1.id).not_to eq(sale2.id)
  end
end
