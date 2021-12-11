directions = [(1, 0), (1, 1), (1, -1), (0, 1), (0, -1), (-1, 1), (-1, 0), (-1, -1)]
function get_neighbour_mask(mask)

    new_mask = zeros(Int, size(mask))

    for x in 1:size(mask, 1)
        for y in 1:size(mask, 2)
            if mask[x, y]
                for dir in directions
                    new_x = dir[1] + x
                    new_y = dir[2] + y

                    if new_x <= 0 || new_y <= 0
                        continue
                    end
                    if new_x > size(mask, 1) || new_y > size(mask, 2)
                        continue
                    end

                    new_mask[new_x, new_y] += 1
                    
                end
            end
        end
    end

    return new_mask

end


function overlap(a1, a2)
    ret = zeros(Bool, size(a1))

    for x in 1:size(a1, 1)
        for y in 1:size(a1, 2)
            ret[x,y] = a1[x, y] && a2[x, y]
        end
    end

    return ret
end

function main()

    input = [[parse(Int, c) for c in line] for line in eachline("input.txt")]
    octomat = hcat(input...)'

    flashes = 0
    for i in 1:100

        repeat = true

        octomat .+= 1
        reset = octomat.==30
        while repeat

            to_flash = octomat.>9
            to_flash[overlap(to_flash , reset)] .= 0
            reset += to_flash

            to_increase = get_neighbour_mask(to_flash)

            octomat += to_increase

            if !any(to_flash)
                repeat = false
            end
        end
        
        flashes += sum(reset)
        octomat[reset.==true] .= 0
        
    end
    println(flashes)
end

main()
