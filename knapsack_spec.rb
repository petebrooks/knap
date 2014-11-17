require 'rspec'
require_relative 'knapsack'
require_relative 'gen_men'

describe Knapsack, '#combinations' do

  context 'for easy menu' do
    let(:easy_knapsack) { Knapsack.new('test_menus/menu1.txt') }
    it 'finds a solution' do
      expect(easy_knapsack.combinations.length).to eq(2)
    end
  end

  context 'for a random solveable menu' do
    let(:solveable_knapsack) { Knapsack.new('test_menus/solveable_menu.txt') }

    it 'finds a solution' do
      expect(solveable_knapsack.combinations).not_to be_empty
    end
  end

  context 'for impossible menu' do
    let(:impossible_knapsack) { Knapsack.new('test_menus/menu2.txt') }

    it 'should return an empty array' do
      expect(impossible_knapsack.combinations).to eq([])
    end
  end

end

