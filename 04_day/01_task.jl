function get_field(lines)
    field = zeros(Int, 1, 5, 5)
    for i in 1:5
        entries = split(lines[i], ' ')
        entries_trimmed = filter(entry -> length(entry) > 0, entries)
        
        field[end, i, 1:end] = parse.(Int, entries_trimmed)
    end

    return field

end

function find_solved(mask)
    victory = [true, true, true, true, true]

    for fieldidx in 1:size(mask, 1)
        field = mask[fieldidx, 1:end, 1:end]

        # rows
        for row in eachrow(field)
            if row == victory
                return fieldidx
            end
        end

        # cols
        for col in eachcol(field)
            if col == victory
                return fieldidx
            end
        end
    end

    return -1
    
end

function get_solution(field, mask)
    good_nums = field[mask .== false]
    return sum(good_nums)
end

function main()
    input = open("input.txt")
	lines = readlines(input)
	close(input)

    drawings = parse.(Int, split(lines[1], ','))
    # remove the next 2 lines
    lines = lines[3:end]

    fields = zeros(Int, 0, 5, 5)
    
    while length(lines) != 0

        fields = cat(fields, get_field(lines[1:5]), dims = 1)
        
        lines = lines[7:end]
    end

    mask = zeros(Bool, axes(fields))

    for number in drawings
        mask[fields .== number] .= true

        result = find_solved(mask)
        if result != -1
            println(get_solution(fields[result, 1:end, 1:end], mask[result, 1:end, 1:end]) * number)
            println(result)
            println(mask[result, 1:end, 1:end])
            break
        end
    end

end

main()
