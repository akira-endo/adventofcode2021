# https://adventofcode.com/2021/day/4
using AdventOfCode
input = begin
    inp=readlines("2021/data/day_4.txt")
    (draws=parse(inp[begin]),
    boards=replace(["[[";inp[begin+2:end].*";";"]]"],";"=>"],[") |>join|>parse)
end

function mark(draw, board)
    markidx=findfirst(x->x==draw,board)
    if isnothing(markidx) return(0) end
    board[markidx]=-1
    if all(<(0),(@view board[markidx[1],:])) || all(<(0),(@view board[:,markidx[2]])) 1 # win
        else 0 end
end
function part_1(input)
    boards=copy.(input.boards) # not to mutate the original input
    res=zeros(size(boards))
    score=0
    for draw in input.draws
        res.+=mark.(draw,boards)
        if any(>(0),res)
            score=sum(max.(boards[findfirst(>(0),res)],0))*draw
            break
        end
    end
    score
end

function part_2(input)
    boards=copy.(input.boards) # not to mutate the original input
    res=zeros(size(boards))
    score=0
    for draw in input.draws
        res.+=mark.(draw,boards)
        if all(>(0),res)
            score=sum(max.(boards[findmin(res)[2]],0))*draw
            break
        end
    end
    score
end
