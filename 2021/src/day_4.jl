# https://adventofcode.com/2021/day/4
using AdventOfCode
evalparse(str::String)=eval(Meta.parse(str))
input = begin
    inp=readlines("2021/data/day_4.txt")
    (draws=evalparse(inp[begin]),
    boards=replace(["[[";inp[begin+2:end].*";";"]]"],";"=>"],[") |>join|>evalparse)
end

function mark(draw, board)
    markidx=findfirst(x->x==draw,board)
    if isnothing(markidx) return(-1) end
    board[markidx]=0
    if iszero(@view board[markidx[1],:]) || iszero(@view board[:,markidx[2]]) # win
        sum(board)*draw
    else -1 end
end
function part_1(input)
    boards=copy.(input.boards) # not to mutate the original input
    res=nothing
    for draw in input.draws
        res=mark.(draw,boards)
        if any(>(-1),res) break end
    end
    maximum(res)
end

function part_2(input)
    boards=copy.(input.boards) # not to mutate the original input
    res=zeros(size(boards))
    for draw in input.draws
        res.+=mark.(draw,boards).+1
        if all(>(0),res) break end
        res[res.>0].=Inf
    end
    Int(minimum(res)-1)
end
