# https://adventofcode.com/2021/day/17
using AdventOfCode

input = ("(".*replace(readlines("2021/data/day_17.txt")[begin], ".."=>":")[begin+12:end].*")")|>parse
ysolve_t(vy, y) = vy+1/2+sqrt((vy+1/2)^2-2y) # when vertical position reaches y
xsolve_t(vx, x) = (vx^2<2x) ? 10000 : (vx+1/2)-sqrt((vx+1/2)^2-2x) # when horizontal position reaches x
ytimerange(vy, input) = (ceil(Int,ysolve_t(vy,last(input.y))):floor(Int,ysolve_t(vy,first(input.y)))) # return integer time range where probe lies within target
xtimerange(vx,input)=(ceil(Int,xsolve_t(vx,first(input.x))):floor(Int,xsolve_t(vx,last(input.x))))

function part_1(input)
    for vy in -minimum(input.y):-1:minimum(input.y)
        if any(any(in(xtimerange(vx,input)),ytimerange(vy,input)) for vx in 1:maximum(input.x))
            return(Int(vy*(vy+1)/2))
        end
    end
end

function part_2(input)
    sum(any(in(xtimerange(vx,input)),ytimerange(vy,input)) for vx in 1:maximum(input.x), vy in -minimum(input.y):-1:minimum(input.y))
end
