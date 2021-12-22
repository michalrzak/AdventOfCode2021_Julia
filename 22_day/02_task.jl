

function overlaps(r1, r2)
    
    for i in 1:length(r1)
        if !(r1[i][1] < r2[i][2] && r1[i][2] > r2[i][1])
            return false
        end
    end
    
    return true

end

function turn_off(off_range, ranges)
    
    new_ranges = copy(ranges)

    for range in ranges
        if overlaps(range, off_range)
            
            candidate_ranges = [[], [], []]
            for i in 1:3
            
                push!(candidate_ranges[i], range[i][1])
                if off_range[i][1] > range[i][1]
                    push!(candidate_ranges[i], off_range[i][1])
                end
                
                if off_range[i][2] < range[i][2]
                    push!(candidate_ranges[i], off_range[i][2])
                end
                push!(candidate_ranges[i], range[i][2])
                
            end
            
            new_areas = []
            
            for xi in 1:length(candidate_ranges[1])-1
                for yi in 1:length(candidate_ranges[2])-1
                    for zi in 1:length(candidate_ranges[3])-1
                        new_range = ((candidate_ranges[1][xi], candidate_ranges[1][xi+1]),
                            (candidate_ranges[2][yi], candidate_ranges[2][yi+1]),
                            (candidate_ranges[3][zi], candidate_ranges[3][zi+1]))
                            
                        if !overlaps(off_range, new_range)
                            push!(new_ranges, new_range)
                        end
                    end
                end
            end
            
            delete!(new_ranges, range)
            
        end
        
    end
    
    return new_ranges

end


function turn_on(on_range, ranges)
    
    new_ranges = turn_off(on_range, ranges)
    push!(new_ranges, on_range)
    return new_ranges

end

function area(ranges)
    
    res = BigInt(0)
    for range in ranges
        ar = 1
        for dim in range
            ar *= abs(dim[1] - dim[2])
        end
        res += ar
    end
    
    return res

end


function main()

    ranges = Set()

    for (i, line) in enumerate(eachline("input.txt"))
        println(i)
        x_s, y_s, z_s = split(split(line, ' ')[2], ',')

        x = parse.(Int, split(x_s[3:end], ".."))
        y = parse.(Int, split(y_s[3:end], ".."))
        z = parse.(Int, split(z_s[3:end], ".."))
        
        x[2] += 1
        y[2] += 1
        z[2] += 1
        
        if line[1:2] == "on"
            ranges = turn_on((Tuple(x), Tuple(y), Tuple(z)), ranges)
        else
            ranges = turn_off((x, y, z), ranges)
        end
        
    end

    println(area(ranges))

end

main()
