# https://adventofcode.com/2021/day/10
using AdventOfCode

input = readlines("2021/data/day_10.txt")
isopen(char::AbstractChar)=char in collect("([{<")
isclose(char::AbstractChar)=char in collect(")]}>")
corruptscore(char::AbstractChar)=Dict(collect(")]}>").=>(3,57,1197,25137))[char]
function readcorruptedline(line)
    memory=Char[]
    for po in 1:length(line)
        hp=line[po]
        if isclose(hp) 
            if abs(hp-memory[end])>2 return(corruptscore(hp)) end
            pop!(memory)
        else
            push!(memory,hp)
        end
    end
    0
end
function part_1(input)
    sum(readcorruptedline, input)
end

function readincompleteline(line)
    memory=Char[]
    for po in 1:length(line)
        hp=line[po]
        if isclose(hp) 
            if abs(hp-memory[end])>2 return(0) end
            pop!(memory)
        else
            push!(memory,hp)
        end
    end
    incompletescore(memory)
end
openscore(char::AbstractChar)=Dict(collect("([{<").=>(1:4))[char]
function incompletescore(openstr)
    if length(openstr)==0 return(0) end
    openscore(openstr[begin])+5incompletescore(openstr[begin+1:end])
end

function part_2(input)
    median(filter(>(0),readincompleteline.(input)))|>Int
end
