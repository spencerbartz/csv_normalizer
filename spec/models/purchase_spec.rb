require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it "should require a purchaser_id" do
    purchase = Purchase.new({ purchaser_id: 1, quantity: 4  })
    expect(purchase.valid?).to be(false)
  end

  it "should require an item_id" do
    purchase = Purchase.new({ purchaser_id: 1, quantity: 4 })
    expect(purchase.valid?).to be(false)
  end

  it "should require a quantity" do
    purchase = Purchase.new({ purchaser_id: 1, item_id: 1 })
    expect(purchase.valid?).to be(false)
  end

  it "should treat all purchases as individual transactions" do
    purchase1 = Purchase.new({ purchaser_id: 1, item_id: 1, quantity: 4 })
    expect(purchase1.valid?).to be(true)
    purchase1.save!

    purchase2 = Purchase.new({ purchaser_id: 1, item_id: 1, quantity: 4 })
    expect(purchase1.valid?).to be(true)
    expect { purchase2.save! }.not_to raise_error(Exception)
    expect(purchase1.id).to_not eq(purchase2.id)
  end
end
