
function main()

    counter = 0
    for line in eachline("input.txt")
        split_line = split(line, " | ")
        signal_patterns = split(split_line[1], ' ')
        output = split(split_line[2], ' ')
        println(length(output[1]))

        counter += count(entry -> (length(entry) == 2 || length(entry) == 3 || length(entry) == 4 || length(entry) == 7), output)
    end

    println(counter)
end

main()
