
function get_distance(v1, v2)

    return ((v1[1] - v2[1]) ^ 2 + (v1[2] - v2[2]) ^ 2 + (v1[3] - v2[3]) ^ 2) ^ (1/2)
    
end


function main()

    input = open("input.txt")
    lines = readlines(input)
    close(input)

    scanners = Array{Array{Tuple{Int, Int, Int}}}([[]])
    for line in lines
        if length(line) == 0
            push!(scanners, [])
            continue
        end
        if line[2] == '-'
            continue
        end

        coords = Tuple(parse.(Int, split(line, ',')))
        push!(scanners[end], coords)
    end

    distances = Array{Matrix{Int}}([])

    for scanner in scanners
        push!(distances, Matrix{Int}(undef, length(scanner), length(scanner)))
        for i in 1:length(scanner)
            for j in i:length(scanner)
                dist = floor(Int, get_distance(scanner[i], scanner[j]))
                distances[end][i, j] = dist
                distances[end][j, i] = dist
            end
        end
    end


    while length(distances) != 1

        distance1 = distances[1]


        found = false
        for j in 2:length(distances)
            distance2 = distances[j]
            
            k = 1
            for row1 in eachrow(distance1)
                l = 1
                
                for row2 in eachrow(distance2)
                    counter = 0
                    for entry in row1
                        if entry in row2
                            counter += 1
                        end
                    end

                    if counter >= 12

                        shift = scanners[1][k] .- scanners[j][l]

                        shifted = Array{Tuple{Int, Int, Int}}([])
                        for point in scanners[j]
                            new_point = point .+ shift

                            push!(shifted, new_point)
                        end

                        normalization = shifted[l]
                        normalized = [s .- normalization for s in shifted]
                        
                        bad_rotation = true

                        flip = [-1 0 0; 0 -1 0; 0 0 -1]
                        x_rotation = [1 0 0; 0 0 -1; 0 1 0]
                        y_rotation = [0 0 1; 0 1 0; -1 0 0]
                        z_rotation = [0 -1 0; 1 0 0; 0 0 1]
                        
                        for x_rot in 1:4
                            for y_rot in 1:4
                                for z_rot in 1:4

                                    c = 0
                                    for point in shifted
                                        if point in scanners[1]
                                            c+=1
                                        end
                                    end

                                    if c >= 12
                                        bad_rotation = false
                                        break
                                    end

                                    normalized = [z_rotation * [p[1]; p[2]; p[3]] for p in normalized]
                                    shifted = [Tuple(p .+ normalization) for p in normalized]
                                    
                                end

                                if !bad_rotation
                                    break
                                end

                                
                                normalized = [y_rotation * [p[1]; p[2]; p[3]] for p in normalized]
                                shifted = [Tuple(p .+ normalization) for p in normalized]
                                
                            end

                            if !bad_rotation
                                break
                            end

                            normalized = [x_rotation * [p[1]; p[2]; p[3]] for p in normalized]
                            shifted = [Tuple(p .+ normalization) for p in normalized]
                        end

                        if bad_rotation
                            break   
                        end

                        for point in shifted
                            if point in scanners[1]
                                continue
                            end
                            push!(scanners[1], Tuple(point))
                        end
                        
                        deleteat!(scanners, j)
                        deleteat!(distances, j)

                        found = true
                        break
                    end

                    if found
                        break
                    end
                    
                    l+=1
                end

                if found
                    break
                end
                
                k += 1
            end

            if found
                break
            end
        end

        # recompute distances of 1
        distances[1] = Matrix{Int}(undef, length(scanners[1]), length(scanners[1]))
        for i in 1:length(scanners[1])
            for j in i:length(scanners[1])
                dist = floor(Int, get_distance(scanners[1][i], scanners[1][j]))
                distances[1][i, j] = dist
                distances[1][j, i] = dist
            end
        end
        

    end
    
    println(length(scanners[1]))
    
end

main()
