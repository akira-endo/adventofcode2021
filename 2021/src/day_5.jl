# https://adventofcode.com/2021/day/5
using AdventOfCode
Base.parse(str::String)=eval(Meta.parse(str))
input = parse.("(".*replace.(readlines("2021/data/day_5.txt"), "->"=>")=>(").*")")
rangestep(x,y,step)=range(x,y,step=step)
function part_1(input)
    lines=filter(x->any(first(x).==last(x)),input)
    limit=maximum(maximum.(vcat(first.(lines),last.(lines))))
    field=zeros(Int,limit,limit)
    ranges=(x->range.(first(x),last(x),step=sign(sum(last(x).-first(x))))).(lines)
    for r in ranges
        field[r[1],r[2]].+=1
    end
    sum(>(1),field)
end

function part_2(input)
    lines=input
    limit=maximum(maximum.(vcat(first.(lines),last.(lines))))
    field=zeros(Int,limit,limit)
    ranges=(x->rangestep.(first(x),last(x),sign.(last(x).-first(x).+eps()).|>Int)).(lines)
    for r in ranges
        field[CartesianIndex.(r[1],r[2])].+=1
    end
    sum(>(1),field)
end