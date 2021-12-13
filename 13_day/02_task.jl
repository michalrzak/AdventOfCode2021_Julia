
function main()

    holes = Set()
    folds = []

    reading_points = true
    for line in eachline("input.txt")
        if reading_points
            if length(line) == 0
                reading_points = false
                continue
            end
            x, y = parse.(Int, split(line, ','))
            push!(holes, (x, y))
        else
            _, _, fold = split(line, ' ')
            coord, val_unparsed = split(fold, '=')
            val = parse(Int, val_unparsed)
            if coord == "y"
                push!(folds, (0, val))
            else
                push!(folds, (val, 0))
            end
        end
    end

    for fold in folds
        new_holes = copy(holes)
        for hole in holes
            if fold[1] == 0 # folding along the y-axis
                if hole[2] > fold[2]
                    delete!(new_holes, hole)
                    new_hole = (hole[1], fold[2] - (hole[2] - fold[2]))
                    push!(new_holes, new_hole)
                end
            else # folding along the x-axis
                if hole[1] > fold[1]
                    delete!(new_holes, hole)
                    new_hole = (fold[1] - (hole[1] - fold[1]), hole[2])
                    push!(new_holes, new_hole)
                end
            end
        end
        holes = new_holes
    end

    x_range = maximum(x -> x[1], holes)
    y_range = maximum(x -> x[2], holes)

    for y in 0:y_range
        for x in 0:x_range
            if (x, y) in holes
                print('#')
            else
                print(' ')
            end
        end
        println()
    end
    
end

main()
