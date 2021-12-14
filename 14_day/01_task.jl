using DataStructures

function main()

    polymer = ""
    rules = Dict()
    read_polymer = true
    for line in eachline("input.txt")

        if line == ""
            read_polymer = false
            continue
        end

        if read_polymer
            polymer = line
        else
            lhs, rhs = split(line, " -> ")
            rules[lhs] = rhs
        end        

    end

    for j in 1:10
        println(j)
        new_polymer = "" * polymer[1]
        for i in 1:length(polymer)-1
            new_polymer *= rules["" * polymer[i] * polymer[i+1]] * polymer[i+1]
        end
        polymer = new_polymer
    end

    occurences = DefaultDict(0)
    for c in polymer
        occurences[c] += 1
    end

    max_c = '\0'
    min_c = '\0'
    for c in occurences
        if max_c == '\0' || occurences[max_c] < c[2]
            max_c = c[1]
        end
        if min_c == '\0' || occurences[min_c] > c[2]
            min_c = c[1]
        end
    end
    println(max_c, " ", min_c)
    println(occurences[max_c] - occurences[min_c])
end
main()
