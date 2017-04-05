require 'rails_helper'

RSpec.describe Item, type: :model do
  it "should require a price" do
    item = Item.new({ description: "Nintendo Entertainment System" })
    expect(item.valid?).to eq(false)
  end

  it "should require a description" do
    item = Item.new({ price: 29.99 })
    expect(item.valid?).to be(false)
  end

  it "should require a unique description but not price" do
    item1 = Item.new({ price: 245.99, description: "Samsung TV" })
    expect(item1.valid?).to be(true)
    item1.save!

    item2 = Item.new({ price: 299.99, description: "Samsung TV" })
    expect(item2.valid?).to be(false)
  end

  it "should allow 2 different items to be sold at the same price" do
    item1 = Item.new({ price: 199.99, description: "Super Nintendo" })
    expect(item1.valid?).to be(true)
    item1.save!

    item2 = Item.new({ price: 199.99, description: "Sega Genesis" })
    expect(item2.valid?).to be(true)
    item2.save!
  end

  it "should not allow saving 2 identical items" do
    item1 = Item.new({ price: 199.99, description: "Intellivision" })
    expect(item1.valid?).to be(true)
    item1.save!

    item2 = Item.new({ price: 199.99, description: "Intellivision" })
    expect(item2.valid?).to be(false)
    expect { item2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
