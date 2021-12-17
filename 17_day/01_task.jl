
function main()

    input = open("input.txt")
    line = readlines(input)[1]
    close(input)

    _, ranges = split(line, ": ")
    x_range, y_range = split(ranges, ", ")
    target_x = parse.(Int, split(x_range[3:end], ".."))
    target_y = parse.(Int, split(y_range[3:end], ".."))


    # find x vel
    vel_x = 1
    summation = 1
    
    while summation < target_x[1]
        vel_x += 1
        summation += vel_x
    end
    println("vel_x: ", vel_x)
    
    # find y vel
    vel_y = abs(target_y[1]) - 1
    println("vel_y: ", vel_y)

    println("ANSWER: ")
    println(vel_y * (vel_y+1) * 1/2)
end

main()
