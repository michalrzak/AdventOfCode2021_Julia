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

function main()

    
    
    input = open("input.txt")
    hexastream = readlines(input)[1]
    close(input)


    bitstream = [b for c in hexastream for b in hex_to_bin(c)]

    res = 0
    while length(bitstream) >= 7
        res += bin_to_dec(bitstream[1:3])
        bitstream = bitstream[4:end]

        pkg_type = bin_to_dec(bitstream[1:3])
        bitstream = bitstream[4:end]
        if pkg_type == 4
            last_number = false
            big_number_bin = ""
            while !last_number
                if bitstream[1] == '0'
                    last_number = true
                end
                big_number_bin *= String(bitstream[2:5])
                bitstream = bitstream[6:end]
            end

            big_number = bin_to_dec(big_number_bin)

        else
            if bitstream[1] == '0'
                bit_len = bin_to_dec(bitstream[2:16])
                bitstream = bitstream[17:end]

                #TODO
                #bitstream = bitstream[bit_len+1:end]
            else
                num_pkg = bin_to_dec(bitstream[2:12])
                bitstream = bitstream[13:end]

                #TODO
                #bitstream = bitstream[11 * num_pkg + 1 : end]
            end
        end
    end

    println(res)
end

main()
