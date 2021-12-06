


function main()
    input = open("input.txt")
	line = readlines(input)
	close(input)

    fish = parse.(Int, split(line[1], ','))
    println(fish)
    fishes_count = zeros(Int, 9)
    for f in fish
        fishes_count[f+1] += 1
    end

    println(fishes_count)


    for i in 1:256
        new_fish = fishes_count[1]
    
        for f in 1:9
            prev = f != 1 ? f - 1 : 8

            fishes_count[prev] += fishes_count[f]
            fishes_count[f] = 0
        end

        fishes_count[9] = new_fish
    end

    println(sum(fishes_count))
    
end

main()
