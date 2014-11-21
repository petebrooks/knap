# Knap
Ruby CLI for knapsack problem

### Install
1. `gem install thor`
2. `git clone <URL>`
3. `cd knap`

### CLI Usage

##### Load a text file and print result:
`thor knap load <FILE_NAME>`  
options:  
`-v` || `--verbose` (default: false)  
`--combinations` (default: false)  
`--counts` (default: false)  
`--to_s` (default: true)  

##### Run all test files:
`thor knap test`  
options:  
`-v` || `--verbose` (default: false)  

##### Help menu:
`thor knap help`


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
