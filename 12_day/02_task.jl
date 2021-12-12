
using DataStructures

function traverse(from, caves, visited_small=Set(), small_twice=false)

    if from == "end"
        return 1
    end

    new_visited_small = copy(visited_small)

    if lowercase(from) == from
        push!(new_visited_small, from)
    end

    #sum(traverse(cave, caves, new_visited) for cave in caves[from] if !(cave in visited))

    res_sum = 0
    for cave in caves[from]
        if cave in new_visited_small && !small_twice && cave != "start"
            res_sum += traverse(cave, caves, new_visited_small, true)
            
        elseif !(cave in new_visited_small)
            res_sum += traverse(cave, caves, new_visited_small, small_twice)
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

    println(traverse("start", caves))
end

main()
