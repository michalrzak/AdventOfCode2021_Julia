
function main()

    input = open("input.txt")
    lines = readlines(input)
    close(input)

    starting_pos = split.(lines, ": ")
    
    def_pos = parse.(Int, [starting_pos[1][2], starting_pos[2][2]])
    def_score = [0, 0]

    def_turn = 1 # true if player 1 is on turn

    states = [(def_pos, def_score, def_turn, 1)]

    wins = [0, 0]

    prob = [1, 3, 6, 7, 6, 3, 1]
    while (length(states) != 0)
        #println(length(states))
        state = pop!(states)
        pos = state[1]
        score = state[2]
        turn = state[3]
        multiplicity = state[4]

        if (all(x -> x < 21, score))

            for i in 3:9

                new_pos = copy(pos)
                new_pos[turn] += i

                if new_pos[turn] > 10
                    new_pos[turn]= new_pos[turn] % 10
                    if new_pos[turn] == 0
                        new_pos[turn] = 10
                    end
                end


                new_score = copy(score)
                new_score[turn] += new_pos[turn]
                
                push!(states, (new_pos, new_score, turn % 2 + 1, multiplicity * prob[i-2]))
                
            end

        else
            wins[score .>= 21] .+= multiplicity
        end


    end
    println(wins)
    println(maximum(wins))

end

main()
