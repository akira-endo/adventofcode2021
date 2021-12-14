# https://adventofcode.com/2021/day/2
using AdventOfCode

input = readlines("2021/data/day_2.txt")

function part_1(input)
    h,d=0,0
    for command in input
        X = parse(Int, match(r"[a-z]* (?<num>\d+)", command)[:num])
        if occursin(r"forward.*",command) h+=X end
        if occursin(r"down.*",command) d+=X end
        if occursin(r"up.*",command) d-=X end
    end
    h*d
end

function part_2(input)
    h,d,aim=0,0,0
    for command in input
        X = parse(Int, match(r"[a-z]* (?<num>\d+)", command)[:num])
        if occursin(r"forward.*",command) h+=X;d+=X*aim end
        if occursin(r"down.*",command) aim+=X end
        if occursin(r"up.*",command) aim-=X end
    end
    h*d
end