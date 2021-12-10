
using DataStructures

function main()

    legal_char_open = ['(', '[', '{', '<']
    legal_char_close = [')', ']', '}', '>']
    points =  [3, 57, 1197, 25137]

    total = 0
    for line in eachline("input.txt")
        chunks = Stack{Char}()
        for c in line
            if c in legal_char_open
                push!(chunks, c)
            else
                char_idx = findfirst(x -> c == x, legal_char_close)

                if first(chunks) != legal_char_open[char_idx]
                    total += points[char_idx]
                    break
                end

                pop!(chunks)
            end
        end
    end

    println(total)

end


main()
