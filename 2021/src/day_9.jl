# https://adventofcode.com/2021/day/9
using AdventOfCode
using StatsBase
CI=CartesianIndex
input = split.(readlines("2021/data/day_9.txt"),"") .|> (x->parse.(Int,x)) |> Base.Fix1(reduce, hcat)

function part_1(input)
    lows=@views min.(input[[begin+1:end;end-1],begin:end],
        input[[begin+1;begin:end-1],begin:end],
        input[begin:end,[begin+1:end;end-1]],
        input[begin:end,[begin+1;begin:end-1]]) .> input
    sum((@view input[lows]).+1)
end
function findbasin(point ,input, lowpoints)
    if input[point]==9 || (point in lowpoints) return(point) end
    CIs=CartesianIndices(input)
    fI, lI = first(CIs), last(CIs)
    neighbors=min.(Ref(lI),max.(Ref(fI), CI.([(1,0),(-1,0),(0,1),(0,-1)]).+ Ref(point)))
    filter!(!in((point,)),neighbors) # get neighbors not including self
    lowneighbor=neighbors[findmin(input[neighbors])[2]]
    findbasin(lowneighbor,input, lowpoints)
end
function part_2(input)
    lows=@views min.(input[[begin+1:end;end-1],begin:end],
        input[[begin+1;begin:end-1],begin:end],
        input[begin:end,[begin+1:end;end-1]],
        input[begin:end,[begin+1;begin:end-1]]) .> input
    lowpoints=findall(lows)
    cm=countmap(findbasin(x,input,lowpoints) for x in CartesianIndices(input))
    collect(sort(cm, byvalue=true))[end-2:end].|>last|>prod
end