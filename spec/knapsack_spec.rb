require 'rspec'
require_relative '../knapsack'

describe Knapsack do
  let(:easy_knapsack) { Knapsack.new('test_menus/menu1.txt') }
  let(:equal_knapsack) { Knapsack.new('test_menus/menu3.txt') }
  let(:solveable_knapsack) { Knapsack.new('test_menus/solveable_menu.txt') }
  let(:impossible_knapsack) { Knapsack.new('test_menus/menu2.txt') }

  describe '#combinations' do
    it 'finds a solution to an easy menu' do
      expect(easy_knapsack.combinations.length).to eq(2)
    end

    it 'finds many solutions when they exist' do
      expect(equal_knapsack.combinations.length).to eq(792)
    end

    it 'finds a solution to a random solveable menu' do
      expect(solveable_knapsack.combinations).not_to be_empty
    end

    it 'returns an empty array for an impossible menu' do
      expect(impossible_knapsack.combinations).to eq([])
    end
  end

  describe '#counts' do
    it 'returns a count for each correct combination' do
      number_of_combos = solveable_knapsack.combinations.length
      expect(solveable_knapsack.counts.length). to eq(number_of_combos)
    end

    it 'returns a count for every item in the solution' do
      combo = solveable_knapsack.combinations.first
      expect(solveable_knapsack.counts.first.keys).to eq(combo.uniq)
    end

    it 'returns an empty array for an impossible menu' do
      expect(impossible_knapsack.counts).to eq([])
    end
  end

  describe '#to_s' do
    it 'returns the correct string representation' do
      expect(easy_knapsack.to_s).to eq("Combination #1:\n   1 mixed fruit\n   2 hot wings\n   1 sampler plate\nCombination #2:\n   7 mixed fruit\n")
    end
  end

  describe '#initialize' do
    it 'raises an error if not initialized with a filename' do
      expect{Knapsack.new('@r$sj')}.to raise_error(ArgumentError)
    end
  end

end