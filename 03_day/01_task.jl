function solve() 
    input = open("input.txt")
	entries = readlines(input)
	close(input)
    ones_count = zeros(Int, length(entries[1]))
    
    for line in entries
        for (idx, bit) in enumerate(line)
            if bit == '1'
                ones_count[idx] += 1
            end
        end
    end
    println(ones_count)
    gamma_rate  = ""
    epsilon_rate = ""
    for one_count in ones_count

        if one_count > length(entries) / 2
            gamma_rate = gamma_rate * "1"
            epsilon_rate = epsilon_rate * "0"
        else
            gamma_rate = gamma_rate * "0"
            epsilon_rate = epsilon_rate * "1"
        end
    end

    print(parse(Int, gamma_rate, base = 2) * parse(Int, epsilon_rate, base = 2))

end

solve()
