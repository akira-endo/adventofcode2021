# https://adventofcode.com/2021/day/12
using AdventOfCode
using Graphs
using Unicode
using Combinatorics
using SimpleWeightedGraphs
input = '"'.*replace.(readlines("2021/data/day_12.txt"),"-"=>"""\"=>\"""").*'"' .|>parse
Unicode.isuppercase(str::AbstractString)=isuppercase(str[1])
strdict=Dict(unique([first.(input);last.(input)]).=> 1:length(unique([first.(input);last.(input)])))
uppers=filter(isuppercase,keys(strdict))
input=(edges=input,strdict=strdict,uppers=uppers)
Graphs.add_edge!(g::Graphs.SimpleGraphs.AbstractSimpleGraph, a::AbstractVector{<:Integer})=add_edge!(g, a[begin],a[begin+1])
function makegraph(input)
    strdict=input.strdict
    g=SimpleWeightedGraph(SimpleGraph(strdict|>length), 1)
    for edge in input.edges
        add_edge!(g,strdict[first(edge)],strdict[last(edge)],1)
    end
    for upvex in getindex.(Ref(strdict),uppers) # for each upper case vertice
        nb=neighbors(g,upvex)|>collect
        for edge in combinations(nb,2)
            add_edge!(g,edge[begin],edge[end],g.weights[edge[begin],edge[end]]+1) # connect among neighbors of upvex
        end
        for edge in zip(nb,nb)
            add_edge!(g,edge[begin],edge[end],g.weights[edge[begin],edge[end]]+1) # add self edges for neighbors
        end
        nb=neighbors(g,upvex)|>collect
        rem_edge!.(Ref(g),upvex,nb) # remove edges from upvex
    end
    g
end
function part_1(input)
    strdict=input.strdict
    g=makegraph(input)
    routes=combinations(setdiff(values(strdict),[strdict["start"];strdict["end"];getindex.(Ref(strdict),uppers)])).|>permutations
    npath = x->prod(getindex.(Ref(g.weights),[strdict["start"];x],[x;strdict["end"]]))
    sum(sum(npath, route) for route in routes)
end
onlyonetwicefilter(vectors)=filter(x->length(x)-length(unique(x))<2,vectors)
function part_2(input)
    strdict=input.strdict
    g=makegraph(input)
    caves=setdiff(values(strdict),[strdict["start"];strdict["end"];getindex.(Ref(strdict),uppers)])
    doublecaves=repeat(caves,2)
    routes=combinations(doublecaves).|>sort|>onlyonetwicefilter|>unique.|>permutations
    npath = x->prod(getindex.(Ref(g.weights),[strdict["start"];x],[x;strdict["end"]]))
    sum(sum(npath, unique(route)) for route in routes)+npath(Int[])
end
