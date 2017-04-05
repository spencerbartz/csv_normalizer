require 'rails_helper'

RSpec.describe Purchaser, type: :model do
  it "should should require a name" do
    purchaser = Purchaser.new
    expect(purchaser.valid?).to be(false)
  end

  it "should not allow 2 purchasers to have the same name" do
    purchaser1 = Purchaser.new({ name: "松橋明裕子" })
    expect(purchaser1.valid?).to be(true)
    purchaser1.save!

    purchaser2 = Purchaser.new({ name: "松橋明裕子"})
    expect(purchaser2.valid?).to be(false)
    expect { purchaser2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
