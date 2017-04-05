require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "should require a name" do
    merchant = Merchant.new({ address: "714 Evergreen Terrace" })
    expect(merchant.valid?).to be(false)
  end

  it "should require an address" do
    merchant = Merchant.new({ name: "John Doe" })
    expect(merchant.valid?).to be(false)
  end

  it "should require a unique name" do
    merchant1 = Merchant.new({ name: "松橋明裕子", address: "200 Market Street" })
    expect(merchant1.valid?).to be(true)
    merchant1.save!

    merchant2 = Merchant.new({ name: "松橋明裕子", address: "1200 Vista Ave." })
    expect(merchant2.valid?).to be(false)
  end

  it "should not allow merchants with the same name" do
    merchant1 = Merchant.new({ name: "松橋明裕子", address: "200 Market Street" })
    expect(merchant1.valid?).to be(true)
    merchant1.save!

    merchant2 = Merchant.new({ name: "松橋明裕子", address: "1200 Vista Ave." })
    expect(merchant2.valid?).to be(false)
    expect { merchant2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
