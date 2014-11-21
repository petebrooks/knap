# Knap
Ruby CLI for knapsack problem

### Install
1. `gem install thor`
2. `git clone <URL>`
3. `cd knap`
4. `thor knap load <FILE_NAME>` || `thor knap help` || `thor knap test`

### Menu Generator
Includes CLI for generating test menus

1. `cd spec`
2. `thor menu_gen` || `thor menu_gen help`

All test files are saved in spec/test_menus

### Syntax
In knapsack.rb:

```ruby
k = Knapsack.new('path/to/file.txt')
k.combinations # returns all combinations of items whose prices add up to target price
k.counts       # returns array of hashes with items as keys and count as values
puts k         # string representation
```
