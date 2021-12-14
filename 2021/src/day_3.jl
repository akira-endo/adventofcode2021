# https://adventofcode.com/2021/day/3
using AdventOfCode
using Statistics
input = (x->parse.(Int,split(x,""))).(readlines("2021/data/day_3.txt"))
function parsebin(binvec::BitArray)
    sum(binvec.*2 .^((length(binvec)-1:-1:0)))
end
parsebin(vec::Vector{<:Int})=parsebin(Bool.(vec))
function part_1(input)
    gammavec= >(0.5).(mean(input))
    parsebin(gammavec)*
        parsebin(.!gammavec)
end

function sift(vectors, meancond, sumvec, digit=1)
    len=length(vectors)
    if len==1 return(parsebin(vectors[1])) end
    filter!(x->x[digit]==meancond(sumvec[digit]/len),vectors)
    sumvec.=sum(vectors)
    sift(vectors,meancond,sumvec,digit+1)
end
function part_2(input)
    sift(copy(input),≥(0.5),sum(input))*
        sift(copy(input),<(0.5),sum(input))
end
