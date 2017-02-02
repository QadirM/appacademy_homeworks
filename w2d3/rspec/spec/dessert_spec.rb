require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:dessert) {Dessert.new("Applepie", 10, chef)}

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("Applepie")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(10)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{ Dessert.new("Applepie", 10.0, chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("flour")
      expect(dessert.ingredients).to eq(["flour"])
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      dessert.add_ingredient("flour")
      dessert.add_ingredient("egg")
      dessert.add_ingredient("apple")
      ingred = dessert.ingredients.dup
      dessert.mix!
      expect(ingred).not_to eq(dessert.ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(4)
      expect(dessert.quantity).to eq(6)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{dessert.eat(15)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize)
      dessert.serve
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake)
      dessert.make_more
    end
  end
end
