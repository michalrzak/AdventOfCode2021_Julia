using DataStructures

function main()

    polymer = DefaultDict(0)
    rules = Dict()
    occurences = DefaultDict(0)
    read_polymer = true
    for line in eachline("input.txt")

        if line == ""
            read_polymer = false
            continue
        end

        if read_polymer
            first_polymer = line[1] * line[2]
            for i in 1:length(line)-1
                polymer[line[i] * line[i+1]] += 1
                occurences["" * line[i]] += 1
            end
            occurences["" * line[end]] += 1
        else
            lhs, rhs = split(line, " -> ")
            rules[lhs] = rhs
        end        

    end

    for j in 1:40
        println(j)
        new_polymer = DefaultDict(0)
        for pair in polymer
                        
            res_c = rules[pair[1]]
            occurences[res_c] += pair[2]
            new_polymer[pair[1][1] * res_c] += pair[2]
            new_polymer[res_c * pair[1][2]] += pair[2]

        end
        polymer = new_polymer
    end
    #println(polymer)

    max_c = maximum(x->x[2], occurences)
    min_c = minimum(x->x[2], occurences)
    println(max_c, " ", min_c)
    println(max_c - min_c)
end
main()
