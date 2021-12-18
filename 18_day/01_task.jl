function add_right(input, number)
    if typeof(input[1]) == Int
        input[1] += number
    else
        add_right(input[1], number)
    end
end

function add_left(input, number)
    if typeof(input[2]) == Int
        input[2] += number
    else
        add_left(input[2], number)
    end
end


function explode(input, depth=1)

    if typeof(input[1]) != Int
        res = explode(input[1], depth+1)
        
        if res[1] == "explode"
            numbers = res[2]

            if numbers[2] != -1
                input[1] = numbers[2]
                numbers[2] = -1
            end

            if numbers[3] != -1 && typeof(input[2]) == Int
                input[2] += numbers[3]
                numbers[3] = -1
            end

            if numbers[3] != -1
                add_right(input[2], numbers[3])
                numbers[3] = -1
            end

            return res[1], numbers
        end
        
    end

    if typeof(input[2]) != Int
        res = explode(input[2], depth+1)

        if res[1] == "explode"
            numbers = res[2]

            if numbers[2] != -1 
                input[2] = numbers[2]
                numbers[2] = -1
            end

            if numbers[1] != -1 && typeof(input[1]) == Int
                input[1] += numbers[1]
                numbers[1] = -1
            end

            if numbers[1] != -1
                add_left(input[1], numbers[1])
                numbers[1] = -1
            end

            return res[1], numbers
        end
    end

    if typeof(input[1]) == Int && typeof(input[2]) == Int && depth > 4
        return "explode", [input[1], 0, input[2]]
    end

    return nothing, nothing

end

function split(input)

    if typeof(input[1]) == Int && input[1] > 9
        input[1] = Array{Any}([floor(Int, input[1] / 2), ceil(Int, input[1] / 2)])
        return "split", nothing
    end

    if typeof(input[1]) != Int
        res = split(input[1])
        
        if res[1] == "split"
            return res
        end
    end
    
    if typeof(input[2]) == Int && input[2] > 9
        input[2] = Array{Any}([floor(Int, input[2] / 2), ceil(Int, input[2] / 2)])
        return "split", nothing
    end
    
    if typeof(input[2]) != Int
        res = split(input[2])

        if res[1] == "split"
            return res
        end
    end

    return nothing, nothing

end


function reduce(input)

    res = explode(input)
    if res == (nothing, nothing)
        res = split(input)
    end
    return res
end

function magnitude(input)

    res_1 = 0
    if typeof(input[1]) == Int
        res_1 = input[1]
    else
        res_1 = magnitude(input[1])
    end

    res_2 = 0
    if typeof(input[2]) == Int
        res_2 = input[2]
    else
        res_2 = magnitude(input[2])
    end

    return 3 * res_1 + 2 * res_2

end


function main()

    input = open("input.txt")
    lines = readlines(input)
    close(input)

    data = []
    stack = []
    number = -1

    for line in lines

        c_data = data
        for c in line
            if c == '['
                push!(c_data, [])
                push!(stack, c_data)
                c_data = c_data[end]
            elseif c == ',' && number != -1
                push!(c_data, number)
                number = -1
            elseif c == ']'
                if number != -1
                    push!(c_data, number)
                    number = -1
                end
                
                c_data = stack[end]
                pop!(stack)            
            elseif c != ','
                if number == -1
                    number = 0
                end

                number = number * 10 + parse(Int, c)
            end
        end
        
        if length(data) == 2

            while(reduce(data) != (nothing, nothing))
                #println(data)
            end
            data = Array{Any}([data])
        end
    end

    data = data[1]

    println(magnitude(data))
end
main()
