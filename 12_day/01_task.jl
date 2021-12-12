
using DataStructures

function traverse(from, caves, visited)
    if from == "end"
        return 1
    end

    new_visited = copy(visited)

    if lowercase(from) == from
        push!(new_visited, from)
    end

    #sum(traverse(cave, caves, new_visited) for cave in caves[from] if !(cave in visited))

    res_sum = 0
    for cave in caves[from]
        if !(cave in visited)
            res_sum += traverse(cave, caves, new_visited)
        end
    end
    return res_sum
end

function main()

    caves = Dict()
    for line in eachline("input.txt")

        from, to = split(line, '-')
        
        if !haskey(caves, from)
            caves[from] = Set()
        end
        if !haskey(caves, to)
            caves[to] = Set()
        end

        push!(caves[from], to)
        push!(caves[to], from)
        
    end

    println(traverse("start", caves, []))
end

main()
