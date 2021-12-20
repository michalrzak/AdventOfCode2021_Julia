
function bin_to_dec(bin_num)
    res = 0
    for i in 1:length(bin_num)
        res += parse(Int, bin_num[i]) * 2 ^ (length(bin_num) - i)
    end

    return res
end

function get_number(number)
    binary = ""

    for n in number
        binary *= n ? "1" : "0"
    end

    return bin_to_dec(binary)
end

function main()

    input = open("input.txt")
    lines = readlines(input)
    close(input)

    enhancement = lines[1]

    default = false
    image = Dict{Tuple{Int64, Int64}, Bool}()

    for (i_line, line) in enumerate(lines[3:end])
        for (i_c, c) in enumerate(line)
            image[(i_c, i_line)] = c == '#'
        end
    end

    from_x = 1
    from_y = 1
    to_x = length(lines[3])
    to_y = length(lines[3:end])
    
    for i in 1:2
        new_image = copy(image)
        for x in from_x-1:to_x+1
            for y in from_y-1:to_y+1
                window = [(x_w, y_w) in keys(image) ? image[(x_w, y_w)] : default for y_w in y-1:y+1 for x_w in x-1:x+1]
                num = get_number(window) + 1

                new_image[(x, y)] = enhancement[num] == '#'
            end
        end

        image = new_image

        if !default
            default = enhancement[1] == '#'
        else
            default = enhancement[end] == '#'
        end
        
        from_x -= 1
        to_x += 1
        from_y -= 1
        to_y += 1
    end

    res = 0
    for ele in image
        if ele[2]
            res += 1
        end
    end

    println(res)
end

main()
