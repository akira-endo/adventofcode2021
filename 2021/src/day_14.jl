# https://adventofcode.com/2021/day/14
using AdventOfCode
using StatsBase
input = readlines("2021/data/day_14.txt")
growrules = Dict('"'.*replace.(input[3:end], " -> "=>"""\"=>\"""").*'"' .|> parse)

indicatorvec(x::Integer, n::Integer)= (1:n).==x
singlecodes=Dict((join(keys(growrules))|>collect|>unique) .=> indicatorvec.(1:10,10))
paircodes=sort(Dict(keys(growrules).=>1:length(growrules)),byvalue=true)
countcodes=Dict(values(paircodes).=>[getindex.(Ref(singlecodes), pc)|>sum for pc in collect.(keys(paircodes))])
input = (template=input[1], growrules = growrules, paircodes=paircodes, singlecodes=singlecodes,countcodes=countcodes)

function ngm(input)
    growpair=collect(input.growrules)
    codes=[join.((gp[1],[gp[1][1:1],gp[2]],[gp[2],gp[1][2:2]])).|> Base.Fix1(getindex,input.paircodes) for gp in input.growrules]|>sort
    ngmat=zeros(Int,length(codes),length(codes))
    for i in 1:length(codes)
        ngmat[codes[i][2],i]+=1
        ngmat[codes[i][3],i]+=1
    end
    ngmat
end
function grow(chain, rules)
    pairchars = [chain[i:i+1] for i in 1:length(chain)-1]
    insets = [getindex.(Ref(input.growrules),pairchars);""]
    hcat(split(chain,""),insets)|>permutedims|>vec|>join
end
function part_1(input)
    res=reduce(grow,(input.growrules for t in 1:10),init=input.template)
    sorted=sort(countmap(res),byvalue=true)|>collect
    sorted[end][2]-sorted[begin][2]
end


function part_2(input)
    pairchars = [input.template[i:i+1] for i in 1:length(input.template)-1]
    inivec=count.((==(x) for x in 1:length(input.paircodes)),Ref(getindex.(Ref(input.paircodes),pairchars)))
    grownpairs=ngm(input)^40*inivec
    countres=(sum(getindex.(Ref(input.countcodes),1:length(grownpairs)).*grownpairs)+
        input.singlecodes[input.template[begin]]+input.singlecodes[input.template[end]]).÷2
    maximum(countres)-minimum(countres)
end