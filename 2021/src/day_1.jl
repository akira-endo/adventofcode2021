# https://adventofcode.com/2021/day/1
using AdventOfCode
input = parse.(Int,readlines("2021/data/day_1.txt"))

function part_1(input)
    sum(>(0),diff(input))
end
    
function part_2(input)
    sum(>(0),input[begin+3:end].-input[begin:end-3])
end