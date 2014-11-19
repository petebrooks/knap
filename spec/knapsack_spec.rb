require 'rspec'
require 'active_support/core_ext/kernel/reporting'
require_relative '../knapsack'

describe Knapsack do
  let(:easy_knapsack) { Knapsack.new('test_menus/easy_menu.txt') }
  let(:equal_knapsack) { Knapsack.new('test_menus/equal_menu.txt') }
  let(:solveable_knapsack) { Knapsack.new('test_menus/solveable_menu.txt') }
  let(:impossible_knapsack) { Knapsack.new('test_menus/impossible_menu.txt') }
  let(:long_knapsack) { Knapsack.new('test_menus/long_menu.txt') }
  let(:no_target) { 'test_menus/no_target.txt' }
  let(:bad_formatting) { 'test_menus/bad_formatting.txt' }
  let(:zero_target) { 'test_menus/zero_target.txt' }

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

    it 'finds a solution to a long menu' do
      expect(long_knapsack.combinations).not_to be_empty
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
      expect{ Knapsack.new('@r$sj') }.to raise_error(ArgumentError)
    end

    it 'raises an error if target is unusable' do
      expect{ Knapsack.new(:no_target) }.to raise_error
    end

    it 'raises an error if target equals 0' do
      expect{ Knapsack.new(:zero_target) }.to raise_error
    end

    it 'alerts user when skipping a line due to bad formatting in verbose mode' do
      output = capture(:stdout) do
        Knapsack.new('test_menus/bad_formatting.txt', true)
      end
      expect(output).to include('Formatting error.  Skipping line:')
    end

    it 'does not raise an error due to bad line formatting' do
      expect{ Knapsack.new('test_menus/bad_formatting.txt') }.not_to raise_error
    end
  end

end