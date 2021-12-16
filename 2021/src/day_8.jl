# https://adventofcode.com/2021/day/8
using AdventOfCode
using Combinatorics
input = split.(readlines("2021/data/day_8.txt"), " | ") .|> (x->split.(x," "))
nseg = Dict((0:9) .=> (6,2,5,5,4,5,6,3,7,6))

defsegs = ("abcefg","cf","acdeg","acdfg","bcdf","abdfg","abdefg","acf","abcdefg","abcdfg")
defsegdict=Dict(Set.(collect.(defsegs)).=> 0:9)

input = (patterns=first.(input), outputs = last.(input), nseg=nseg, defsegdict=defsegdict)
function iteratedict(v::AbstractVector)
    (Dict(v.=> permv) for permv in permutations(v))
end
vec2nseg(v,input)=getindex.(Ref(input.nseg),v)
translateset(transdict, set)=getindex.(Ref(transdict),set)|>Set

function part_1(input)
    outputnsegs=(length.(x) for x in input.outputs) # vector whose elements [w, x, y, z] are 4 segment numbers of each output
    sum(sum(Base.Fix2(in, getindex.(Ref(input.nseg),(1,4,7,8))) ,x) for x in outputnsegs)
end

function part_2(input)
    sum(begin
        matchdict=iteratedict(collect("abcdefg"))|>collect # all possible translations
        translator=filter(dict->translateset.(Ref(dict),
            Set.([collect.(pattern);collect.(output)])) .|> 
            Base.Fix2(in, keys(input.defsegdict)) |> all,matchdict) |>first # filter those making sense
        translateset.(Ref(translator), Set.(collect.(output))) .|> 
            Base.Fix1(getindex,input.defsegdict) |> join |> parse # translate output
    end
        for (pattern,output) in zip(input.patterns, input.outputs))
end
