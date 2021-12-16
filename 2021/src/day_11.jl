# https://adventofcode.com/2021/day/11
using AdventOfCode

input = split.(readlines("2021/data/day_11.txt"),"") |> Base.Fix1(reduce,hcat) .|> parse

function part_1(input)
    oct=copy(input)
    CIs=CartesianIndices(oct)
    fI, lI = first(CIs), last(CIs)
    I1 = oneunit(fI)
    flashes=0
    for t in 1:100
        oct.+=1
        while(any(oct.>9))
            excitedI=CIs[oct .> 9]
            for eI in excitedI
                neighbors=@view (oct[max(fI,eI-I1):min(lI,eI+I1)])
                neighbors.+=sign.(neighbors)
            end
            oct[excitedI].=0
        end
        flashes+=sum(==(0),oct)
    end
    flashes
end

function part_2(input)
    oct=copy(input)
    CIs=CartesianIndices(oct)
    fI, lI = first(CIs), last(CIs)
    I1 = oneunit(fI)
    t=0
    while true
        t+=1
        oct.+=1
        while(any(oct.>9))
            excitedI=CIs[oct .> 9]
            for eI in excitedI
                neighbors=@view (oct[max(fI,eI-I1):min(lI,eI+I1)])
                neighbors.+=sign.(neighbors)
            end
            oct[excitedI].=0
        end
    if all(==(0),oct) return(t) end
    end
end