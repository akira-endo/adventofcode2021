# https://adventofcode.com/2021/day/7
using AdventOfCode

input = parse.(readlines("2021/data/day_7.txt"))[begin]

function part_1(input)
    med=Int(median(input))
    sum(abs∘Base.Fix2(-,med),input)
end
function part_2(input)
    μ=mean(input)
    minimum(sum((x->x^2+abs(x))∘Base.Fix2(-,m),input)÷2 for m in (floor(Int,μ),ceil(Int,µ)))
end
