function bin_to_dec(bin_num)

    res = 0
    for i in 1:length(bin_num)
        res += parse(Int, bin_num[i]) * 2 ^ (length(bin_num) - i)
    end

    return res
end


function dec_to_bin(dec_num)
    res = ""
    while dec_num != 0
        res = string(dec_num % 2) * res

        dec_num ÷= 2
    end

    if length(res) != 4
        res = "0"^(4 - length(res) % 4) * res
    end

    return res
end

# only for one hex character
function hex_to_dec(hex_num)
    hexadec_to_bin = Dict('A' => 10, 'B' => 11, 'C' => 12, 'D' => 13, 'E' => 14, 'F' => 15)

    res = tryparse(Int, string(hex_num))
    if res == nothing
        res = hexadec_to_bin[hex_num]
    end

    return res

end

function hex_to_bin(hex_num)

    return dec_to_bin(hex_to_dec(hex_num))
    
end


function process_next(bitstream)
    #res += bin_to_dec(bitstream[1:3])
    bitstream = bitstream[4:end]

    pkg_type = bin_to_dec(bitstream[1:3])
    bitstream = bitstream[4:end]

    skip = 0
    res = 0
    if pkg_type == 4
        skip, res = process_literal(bitstream)
    else
        skip, res = process_operation(bitstream, pkg_type)
    end
    return (skip + 6, res)
end

function process_literal(bitstream)
    last_number = false
    big_number_bin = ""
    used = 0
    while !last_number
        if bitstream[1] == '0'
            last_number = true
        end
        big_number_bin *= String(bitstream[2:5])
        bitstream = bitstream[6:end]
        used += 5
    end

    big_number = bin_to_dec(big_number_bin)

    return (used, big_number)
end


function process_operation(bitstream, op_type)

    version = bitstream[1]
    bitstream = bitstream[2:end]
    used = 1

    op_results = []
    if version == '0'
        bit_len = bin_to_dec(bitstream[1:15])
        bitstream = bitstream[16:end]
        used += 15
        prev_len = length(bitstream)

        while prev_len - length(bitstream) != bit_len
            skip, res = process_next(bitstream)
            bitstream = bitstream[skip+1:end]
            used += skip

            push!(op_results, res)
        end

    else
        num_pkg = bin_to_dec(bitstream[1:11])
        bitstream = bitstream[12:end]
        used += 11

        for i in 1:num_pkg
            skip, res = process_next(bitstream)
            bitstream = bitstream[skip+1:end]
            used += skip

            push!(op_results, res)
        end
    end

    res = 0
    if op_type == 0
        res = sum(op_results)
    elseif op_type == 1
        res = prod(op_results)
    elseif op_type == 2
        res = minimum(op_results)
    elseif op_type == 3
        res = maximum(op_results)
    elseif op_type == 5
        res = op_results[1] > op_results[2] ? 1 : 0
    elseif op_type == 6
        res = op_results[1] < op_results[2] ? 1 : 0
    elseif op_type == 7
        res = op_results[1] == op_results[2] ? 1 : 0
    end

    return used, res
end

function main()

    input = open("input.txt")
    hexastream = readlines(input)[1]
    close(input)


    bitstream = [b for c in hexastream for b in hex_to_bin(c)]

    while length(bitstream) >= 7
        skip, res = process_next(bitstream)
        bitstream = bitstream[skip+1 : end]
        println(res)
    end

end

main()
