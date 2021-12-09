
neighbours = [(-1, 0), (1, 0), (0, -1), (0, 1)]
function floodfill(map, mask, x, y)

    if x <= 0 || y <= 0
        return 0
    end
    if x > size(map, 1) || y > size(map, 2)
        return 0
    end

    if mask[x, y] == true
        return 0
    end
    
    value = map[x, y]
    if value == 9
        return 0
    end

    mask[x, y] = true

    res = 0
    for neighbour in neighbours
        new_x = neighbour[1] + x
        new_y = neighbour[2] + y

        res += floodfill(map, mask, new_x, new_y);
    end

    return res+1
        
end

function main()

    map = [[parse(Int, c) for c in line] for line in eachline("input.txt")]
    height_map = hcat(map...)
    mask = zeros(Bool, size(height_map))

    largest_basins = [0, 0, 0]
    for x in 1:size(height_map, 1)
        for y in 1:size(height_map, 2)
            if mask[x, y] == false
                new_basin = floodfill(height_map, mask, x, y)

                for i in 1:length(largest_basins)
                    if new_basin > largest_basins[i]
                        temp = largest_basins[i]
                        largest_basins[i] = new_basin
                        new_basin = temp
                    end
                end
            end
        end
    end

    println(prod(largest_basins))
end

main()
