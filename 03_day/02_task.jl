function find_task2_row(numbers, comparison)
    my_numbers = copy(numbers)

    for column_idx in 1 : size(my_numbers, 2)
        ones = sum(my_numbers[1:end, column_idx])

        good_rows = []
        if comparison(ones, size(my_numbers, 1) / 2)
            good_rows = my_numbers[my_numbers[1:end, column_idx] .== 1, 1:end]
        else
            good_rows = my_numbers[my_numbers[1:end, column_idx] .== 0, 1:end]
        end

        my_numbers = good_rows

        if size(my_numbers, 1) == 1
            break
        end
        
    end

    return my_numbers[1, 1:end]

end

function bin_array2dec(bin_array)
    res = 0

    for (idx, ele) in enumerate(bin_array)
        res += ele * 2 ^ (length(bin_array) - idx)
    end

    return res
end

function solve() 
    input = open("input.txt")
	entries = readlines(input)
	close(input)
    ones_count = zeros(Int, length(entries[1]))

    numbers = zeros(Int, (length(entries), length(entries[1])))
    for (y, line) in enumerate(entries)
        for (x, bit) in enumerate(line)
            if bit == '1'
                numbers[y, x] = 1
            end
        end
    end

    oxygen = find_task2_row(numbers, (lhs, rhs) -> lhs >= rhs)

    co2 = find_task2_row(numbers, (lhs, rhs) -> lhs < rhs)

    println(oxygen)
    println(co2)

    println(bin_array2dec(oxygen) * bin_array2dec(co2))
end

solve()

