# https://adventofcode.com/2021/day/13
using AdventOfCode

input = readlines("2021/data/day_13.txt")
dots=parse.(input[begin:begin+findfirst(==(""),input)-2])
folds=replace.(input[begin+findfirst(==(""),input):end],"fold along "=>":")
folds=replace.(folds,"="=>"=>").|>parse
axes=Dict(:x=>1,:y=>2)
input=(dots=dots,folds=folds,axes=axes)

function makepaper(input)
    papersize = ((maximum.(input.dots)|>maximum) +1)*2
    paper=zeros(Bool,papersize,papersize)
    paper[CartesianIndex.(input.dots).+Ref(CartesianIndex(1,1))].=1
    paper
end

function fold!(paper, foldselem)
    axis,at = foldselem
    if axis==:x
        paper[1:at,:] .= paper[1:at,:].| paper[1+at.+(at:-1:1),:]
        paper[at+1:end,:].=0
    end
    if axis==:y
        @views paper[:,1:at] .= paper[:,1:at].| paper[:,1+at.+(at:-1:1)]
        paper[:,at+1:end].=0
    end
end
function part_1(input)
    paper=makepaper(input)
    fold!(paper,input.folds[1])
    count(paper)
end

function part_2(input)
    paper=makepaper(input)
    fold!.(Ref(paper),input.folds)
    println.(eachrow((Int.(paper)')[1:6,1:40]).|>join)
    nothing
end
