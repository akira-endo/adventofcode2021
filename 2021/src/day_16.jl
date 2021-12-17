# https://adventofcode.com/2021/day/16
using AdventOfCode
hex2bin(x)=lpad.(string.(x |>hex2bytes, base=2),8,"0")|>join
input = hex2bin(readlines("2021/data/day_16.txt")|>first)
bin2Int(x)=parse(Int,x,base=2)
function readliteral!(str,head)
    head[]+=5
    if bin2Int(str[head[]-5])==0
        return(str[head[]-4:head[]-1])
    end
    join([str[head[]-4:head[]-1];readliteral!(str,head)])
end
function readpacket!(str,head=fill(1))
    ver=bin2Int(str[head[]:head[]+2])
    head[]+=3
    typ=bin2Int(str[head[]:head[]+2])
    head[]+=3
    if typ == 4 # literal
        return((ver=ver,typ=typ,content=readliteral!(str,head)|>bin2Int))
    end
    lentype=ifelse(str[head[]]=='0', 15, 11) # length type 15 or 11   
    head[]+=1
    len=bin2Int(str[head[]:head[]+lentype-1])
    head[]+=lentype
    origin=head[]
    subpackets=[]
    while((lentype==15&&head[]<origin+len) || (lentype==11 &&length(subpackets)<len))
        push!(subpackets,readpacket!(str,head))
    end
    return((ver=ver,typ=typ,content=subpackets))
end
function sumver(packet)
    if packet.typ==4 return(packet.ver) end
    sum(sumver,(packet.content))+packet.ver
end
function evalpacket(packet)
    if packet.typ==4 return(packet.content) end
    if packet.typ==0 return(sum(evalpacket.(packet.content))) end
    if packet.typ==1 return(prod(evalpacket.(packet.content))) end
    if packet.typ==2 return(minimum(evalpacket.(packet.content))) end
    if packet.typ==3 return(maximum(evalpacket.(packet.content))) end
    if packet.typ==5 return(>(evalpacket.(packet.content)...)) end
    if packet.typ==6 return(<(evalpacket.(packet.content)...)|>Int) end
    if packet.typ==7 return(==(evalpacket.(packet.content)...)|>Int) end
end
function part_1(input)
    sumver(readpacket!(input))
end

function part_2(input)
    evalpacket(readpacket!(input))
end
