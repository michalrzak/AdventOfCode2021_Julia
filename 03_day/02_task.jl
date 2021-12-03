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

        if one_count >= length(entries) / 2
            gamma_rate = gamma_rate * "1"
            epsilon_rate = epsilon_rate * "0"
        else
            gamma_rate = gamma_rate * "0"
            epsilon_rate = epsilon_rate * "1"
        end
    end

    println(parse(Int, gamma_rate, base = 2) * parse(Int, epsilon_rate, base = 2))
    
    numbers = zeros(Int, (length(entries), length(entries[1])))
    for (y, line) in enumerate(entries)
        for (x, bit) in enumerate(line)
            if bit == '1'
                numbers[y, x] = 1
            end
        end
    end
    println(numbers[1, 1:end])
    
    
    oxygen_candidates = copy(numbers)
    co2_candidates = copy(numbers)
    
    
    # oxygen
    x_idx = 1
    while (size(oxygen_candidates, 1) > 1)
        bit_count = sum(oxygen_candidates, dims = 1)
        println(bit_count)
        
        new_candidates = reshape(Int[], 0, size(oxygen_candidates, 2))
        println(new_candidates)
        for candidate in eachrow(oxygen_candidates)
            if (bit_count[x_idx] >= size(oxygen_candidates, 1) / 2 && candidate[x_idx] == 1)
                new_candidates = vcat(new_candidates, candidate')
            elseif (bit_count[x_idx] < size(oxygen_candidates, 1) / 2 && candidate[x_idx] == 0)
                new_candidates = vcat(new_candidates, candidate')
            end
        end
        println(new_candidates)
        
        oxygen_candidates = new_candidates
        println(oxygen_candidates)
        x_idx += 1
    end
    
    # co2
    x_idx = 1
    println("here we go:")
    println(co2_candidates)
    while (size(co2_candidates, 1) > 1)
        bit_count = sum(co2_candidates, dims = 1)
        println(bit_count)
        
        new_candidates = reshape(Int[], 0, size(co2_candidates, 2))
        println(new_candidates)
        for candidate in eachrow(co2_candidates)
            if (bit_count[x_idx] >= size(co2_candidates, 1) / 2 && candidate[x_idx] == 0)
                new_candidates = vcat(new_candidates, candidate')
            elseif (bit_count[x_idx] < size(co2_candidates, 1) / 2 && candidate[x_idx] == 1)
                new_candidates = vcat(new_candidates, candidate')
            end
        end
        println("help")
        println(new_candidates)
        
        co2_candidates = new_candidates
        println(oxygen_candidates)
        x_idx += 1
    end
    
    

    println(gamma_rate)
    println(oxygen_candidates[1, 1:end])
    println(length(oxygen_candidates))
    println(co2_candidates[1, 1:end])
    println(length(co2_candidates))
    # println(parse(Int, oxygen_candidates[1, 1:end], base = 2) * parse(Int, co2_candidates[1, 1:end], base = 2))


end

solve()
