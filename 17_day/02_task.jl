
function main()

    input = open("input.txt")
    line = readlines(input)[1]
    close(input)

    _, ranges = split(line, ": ")
    x_range, y_range = split(ranges, ", ")
    target_x = parse.(Int, split(x_range[3:end], ".."))
    target_y = parse.(Int, split(y_range[3:end], ".."))


    # find x vel
    min_vel_x = 1
    summation = 1
    
    while summation < target_x[1]
        min_vel_x += 1
        summation += min_vel_x
    end
    
    # find y vel
    max_vel_y = abs(target_y[1]) - 1

    counter = 0
    for x in min_vel_x : target_x[2]
        for y in target_y[1] : max_vel_y
            probe_x = 0
            probe_y = 0
            vel_x = x
            vel_y = y
            while(probe_y > target_y[1])
                
                probe_x += vel_x
                probe_y += vel_y

                if vel_x > 0
                    vel_x -= 1
                elseif vel_x < 0
                    vel_x += 1
                end
                vel_y -= 1

                if probe_y >= target_y[1] && probe_y <= target_y[2] && probe_x >= target_x[1] && probe_x <= target_x[2]
                    counter += 1
                    break
                end
            end
        end
    end 
    println(counter)
end

main()
