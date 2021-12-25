
function main()

    input = [[c for c in line] for line in eachline("input.txt")]
    floor = hcat(input...)

    
    east = Set([(x, y) for y in 1:size(floor, 2) for x in 1:size(floor, 1) if (floor[x, y] == '>')])
    south = Set([(x, y) for y in 1:size(floor, 2) for x in 1:size(floor, 1) if (floor[x, y] == 'v')])

    counter = 0
    movement = true
    while movement
        
        """
        println(counter)
        for row in eachcol(floor)
            for c in row
                print(c)
            end
            println()
        end
        println()
        """
        
        
        counter += 1
        movement = false
        
        new_floor = copy(floor)
        new_east = copy(east)
        for cucumber in east
            new_cucumber = (cucumber[1] % size(floor, 1) + 1, cucumber[2])
            
            if floor[new_cucumber[1], new_cucumber[2]] == '.'
                delete!(new_east, cucumber)
                push!(new_east, new_cucumber)
                
                new_floor[cucumber[1], cucumber[2]] = '.'
                new_floor[new_cucumber[1], new_cucumber[2]] = '>'
                
                movement = true
            end
        end
        east = new_east
        floor = new_floor
        
        new_floor = copy(floor)
        new_south = copy(south)
        for cucumber in south
            new_cucumber = (cucumber[1], cucumber[2] % size(floor, 2) + 1)

            
            if floor[new_cucumber[1], new_cucumber[2]] == '.'
                delete!(new_south, cucumber)
                push!(new_south, new_cucumber)
                
                new_floor[cucumber[1], cucumber[2]] = '.'
                new_floor[new_cucumber[1], new_cucumber[2]] = 'v'
                
                movement = true
            end
        end
        south = new_south
        floor = new_floor
        
    end
    
    println(counter)

end

main()
