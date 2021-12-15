
function main()
    input = [[parse(Int, c) for c in line] for line in eachline("input.txt")]
    costs = hcat(input...)'

    endpoints = Set([((1, 1), [], 0)]) # x, y, path, cost
    visited = Set([(1, 1)])

    directions = Set([(1, 0), (0, 1), (-1, 0), (0, -1)])
    finnished = false
    while !finnished
        step_not_found = true
        smallest_step = ((-1, -1), [], -1) # ((-1, -1), -1) == unset; I know this is very quick and very dirty

        new_endpoints = copy(endpoints)
        for endpoint in endpoints
            x = endpoint[1][1]
            y = endpoint[1][2]

            none_visited = true
            for dir in directions
                x_new = x + dir[1]
                y_new = y + dir[2]

                if x_new <= 0 || y_new <= 0
                    continue
                end
                if x_new > size(costs, 1) || y_new > size(costs, 2)
                    continue
                end

                if !((x_new, y_new) in visited)
                    none_visited = false
                    if step_not_found || endpoint[3] + costs[x_new, y_new] < smallest_step[3]
                        new_path = copy(endpoint[2])
                        push!(new_path, (x_new, y_new))
                        smallest_step = ((x_new, y_new), new_path, endpoint[3] + costs[x_new, y_new])
                        step_not_found = false
                    end
                end
            end
            if none_visited
                delete!(new_endpoints, endpoint)
            end
        end

        endpoints = new_endpoints
        push!(endpoints, smallest_step)
        push!(visited, smallest_step[1])

        if smallest_step[1] == (size(costs, 1), size(costs, 2))
            finnished = true
        end

    end

    for endpoint in endpoints
        if endpoint[1] == (size(costs, 1), size(costs, 2))
            println(endpoint[2])
            println(endpoint[3])
            break
        end
    end    
    
end

main()
