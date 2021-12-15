# https://adventofcode.com/2021/day/6
using AdventOfCode
input = parse.(readlines("2021/data/day_6.txt"))[begin]
function sim(input, until)
    state=count.(.==(0:6),Ref(input))
    newborn=zeros(Int,7)
    for t in 1:until
        newborn[begin+(t+1)%7]=state[begin+(t-1)%7]
        state[begin+(t-1)%7]+=newborn[begin+(t-1)%7]
        newborn[begin+(t-1)%7]=0
    end
    sum(state)+sum(newborn)
end
function part_1(input)
    sim(input,80)
end
function part_2(input)
    sim(input,256)
end
