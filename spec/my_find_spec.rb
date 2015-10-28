require_relative 'spec_helper'
require_relative '../lib/my_find.rb'

describe "#my_find" do
  let(:collection) { (1..100).to_a }

  it "does not call on all?" do
    expect(collection).to_not receive(:find)
  end

  it "can handle an empty collection" do
    counter=0
    my_find([]) do |x|
      counter+=1
    end
    expect(counter).to eq(0)
  end

  it "yields the correct element to the block" do
    yielded = []
    my_find(collection) do |number|
      yielded.push number
    end
    expect(yielded).to eq(collection)
  end

  it "returns the elements from the array when the block condition is met" do
    expect(my_find(collection) {|i| i % 3 == 0 && i % 5 == 0 }).to eq([15, 30, 45, 60, 75, 90])
  end
  
  it "returns an empty array when the block condition is not met" do
    expect(my_find(collection) {|i| i % 200 == 0}).to eq([])
  end
end