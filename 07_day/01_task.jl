
function main()

    input = open("input.txt")
	positions = parse.(Int, split(readlines(input)[1], ','))
	close(input)

    min_cost = -1
    for i in minimum(positions):maximum(positions)
        cost = sum(abs.(positions .- i))

        if min_cost == -1 || min_cost > cost
            min_cost = cost
        end
    end

    println(min_cost)
end

main()
