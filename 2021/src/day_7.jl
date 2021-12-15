# https://adventofcode.com/2021/day/7
using AdventOfCode

input = parse.(readlines("2021/data/day_7.txt"))[begin]

function part_1(input)
    med=Int(median(input))
    sum(abs∘Base.Fix2(-,med),input)
end
function part_2(input)
    mid=round(Int,mean(input)-sum(sign,input)/2length(input))
    sum((x->x^2+abs(x))∘Base.Fix2(-,mid),input)÷2
end
