function get_pipe_points(begin_coord, end_coord)
    if begin_coord[1] != end_coord[1] && begin_coord[2] != end_coord[2]
        # the pipes are not horizontal/vertical
        return []
    end

    x_dif = abs(begin_coord[1] - end_coord[1])
    y_dif = abs(begin_coord[2] - end_coord[2])

    x_points, y_points = Array.(LinRange.(begin_coord, end_coord, floor(Int, sqrt(x_dif ^ 2 + y_dif ^ 2)) + 1))
    return [round.(Int, (x, y)) for (x, y) in zip(x_points, y_points)]
    
end


function main()
    input = open("input.txt")
	lines = readlines(input)
	close(input)

    seefloor = Dict()
    
    coords = split.(lines, " -> ")

    for coord in coords
        begin_coord, end_coord = split.(coord, ",")

        begin_coord = parse.(Int, begin_coord)
        end_coord = parse.(Int, end_coord)
        
        pipe_points = get_pipe_points(begin_coord, end_coord)
        for point in pipe_points
            if !haskey(seefloor, point)
                seefloor[point] = 0
            end

            seefloor[point] += 1
        end
        
    end

    println(length(filter(p -> (p[2] >= 2), seefloor)))
end

main()
