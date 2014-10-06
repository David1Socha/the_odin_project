require_relative '../custom_enumerable'

describe "my_all method" do
  
  it "returns true when block is true for all elements" do
    expect((1..8).my_all?{|num| num < 10}).to be true
  end

  it "returns false when block is false for all elements" do
    expect((4...9).my_all?{|num| num < 2}).to be false
  end

  it "returns false when block is false for only one element" do
    expect((1..10).my_all?{|num| num < 10}).to be false
  end

  it "returns true when no block is passed and no elements are false (or nil)" do
    expect(['hi', 'hello', 'howdy'].my_all?).to be true
  end

  it "returns false when no block is passed and some elements are false (or nil)" do
    expect([42, :test, false].my_all?).to be false
  end

end