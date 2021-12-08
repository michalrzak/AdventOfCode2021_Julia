
function contains(str1, str2)
    for c in str2
        if !(c in str1)
            return false
        end
    end
    return true
end

function differ_by_one(str1, str2)

    found_diff = false
    for c in str2
        if !(c in str1)
            if found_diff
                return false
            end

            found_diff = true
        end
    end

    return found_diff
end

function sort_str(str)
    return join(sort(collect(str)))
end

function find_segment_mapping(input)
    segment_mapping = ["", "", "", "", "", "", "", "", "", ""]
    # find a 1
    pattern = findfirst(p->length(p) == 2, input)

    if pattern != nothing
        segment_mapping[1] = input[pattern]
    end

    # find a 4
    pattern = findfirst(p->length(p) == 4, input)

    if pattern != nothing
        segment_mapping[4] = input[pattern]
    end
    
    # find a 7
    pattern = findfirst(p->length(p) == 3, input)

    if pattern != nothing
        segment_mapping[7] = input[pattern]
    end

    # find an 8
    pattern = findfirst(p->length(p) == 7, input)

    if pattern != nothing
        segment_mapping[8] = input[pattern]
    end

    # we know how a 1, a 4, a 7 and an 8 look like,
    # from this we can deduce other letters

    # 1.) 3 when 1 in sequence and 5 long
    pattern = findfirst(p->length(p) == 5 && contains(p, segment_mapping[1]), input)

    if pattern != nothing
        segment_mapping[3] = input[pattern]
    end
    
    # 2.) 9 when 4 in sequence and 6 long
    pattern = findfirst(p-> !(p in segment_mapping) && length(p) == 6 && contains(p, segment_mapping[4]), input)

    if pattern != nothing
        segment_mapping[9] = input[pattern]
    end
    
    # 3.) 0 when 1 in sequence and 6 long
    pattern = findfirst(p-> !(p in segment_mapping) && length(p) == 6 && contains(p, segment_mapping[1]), input)

    if pattern != nothing
        segment_mapping[10] = input[pattern]
    end
    
    # 4.) 6 when 6 long
    pattern = findfirst(p-> !(p in segment_mapping) && length(p) == 6, input)

    if pattern != nothing
        segment_mapping[6] = input[pattern]
    end
    
    # 5.) 5 when 6 and 5 differ by one elem
    pattern = findfirst(p-> !(p in segment_mapping) && differ_by_one(p, segment_mapping[6]), input)

    if pattern != nothing
        segment_mapping[5] = input[pattern]
    end
    
    # 2.) else
    pattern = findfirst(p-> !(p in segment_mapping), input)

    if pattern != nothing
        segment_mapping[2] = input[pattern]
    end

    return segment_mapping
end

function main()

    signal_patterns = []
    outputs = []
    counter = 0
    for line in eachline("input.txt")
        split_line = split(line, " | ")
        signal_pattern = sort_str.(split(split_line[1], ' '))
        output = sort_str.(split(split_line[2], ' '))

        mapping = find_segment_mapping(signal_pattern)

        output_value = 0
        for entry in output
            output_value = output_value * 10 + findfirst(p->p==entry, mapping) % 10
        end

        counter += output_value
    end

    println(counter)
end

main()
