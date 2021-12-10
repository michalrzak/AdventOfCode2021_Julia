
using DataStructures

function main()

    legal_char_open = ['(', '[', '{', '<']
    legal_char_close = [')', ']', '}', '>']

    totals = []
    for line in eachline("input.txt")
        chunks = Stack{Char}()
        for c in line
            if c in legal_char_open
                push!(chunks, c)
            else
                char_idx = findfirst(x -> c == x, legal_char_close)

                if first(chunks) != legal_char_open[char_idx]
                    empty!(chunks)
                    break
                end

                pop!(chunks)
            end
        end
        if !isempty(chunks)
            push!(totals, 0)
            while !isempty(chunks)
                totals[end] *= 5
                totals[end] += findfirst(x -> first(chunks) == x, legal_char_open)
                pop!(chunks)
            end
        end
    end

    println(sort(totals)[ceil(Int, length(totals)/2)])

end


main()
