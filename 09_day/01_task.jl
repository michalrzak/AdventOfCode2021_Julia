
function all_neighbours_larger(map, x, y)
    neighbours = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    value = map[x, y]

    for neighbour in neighbours
        new_x = neighbour[1] + x
        new_y = neighbour[2] + y
        if new_x <= 0 || new_y <= 0
            continue
        end
        if new_x > size(map, 1) || new_y > size(map, 2)
            continue
        end

        if map[new_x, new_y] <= value
            return false
        end
    end

    return true
end

function main()

    map = [[parse(Int, c) for c in line] for line in eachline("input.txt")]
    height_map = hcat(map...)

    risk = 0
    for x in 1:size(height_map, 1)
        for y in 1:size(height_map, 2)
            if all_neighbours_larger(height_map, x, y)
                risk += 1 + height_map[x, y]
            end
        end
    end

    println(risk)
end

main()
