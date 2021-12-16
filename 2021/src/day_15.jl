# https://adventofcode.com/2021/day/15
using AdventOfCode
using Graphs
using SimpleWeightedGraphs

input = split.(readlines("2021/data/day_15.txt"),"") |> Base.Fix1(reduce,hcat) .|> parse
function makegraph(mat)
    g=SimpleWeightedGraph(Graphs.SimpleGraphs.grid(size(mat)), 1)
    for edge in edges(g)
        w=mat[src(edge)]+mat[dst(edge)]
        add_edge!(g,src(edge),dst(edge),w)
    end
    g
end

function part_1(input)
    g=makegraph(input)
    ds=dijkstra_shortest_paths(g,1)
    (ds.dists[end]-input[begin]+input[end])÷2
end

function part_2(input)
    fullmap=(repeat(input,5,5).+
        repeat((0:4).+(0:4)',inner=size(input)).-1) .%9 .+1
    g=makegraph(fullmap)
    ds=dijkstra_shortest_paths(g,1)
    (ds.dists[end]-input[begin]+input[end])÷2
end
