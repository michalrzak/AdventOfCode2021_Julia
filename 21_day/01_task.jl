mutable struct Dice
    current
    function Dice()
        return new(1)
    end
end

function roll(dice::Dice)
    prev = dice.current
    dice.current += 1
    if dice.current > 100
        dice.current = 1
    end
    
    return prev
end


function main()

    input = open("input.txt")
    lines = readlines(input)
    close(input)

    starting_pos = split.(lines, ": ")
    
    pos = parse.(Int, [starting_pos[1][2], starting_pos[2][2]])
    score = [0, 0]

    dice = Dice()

    turn = 1 # true if player 1 is on turn

    turn_count = 0
    while (all(x -> x < 1000, score))
        for i in 1:3
            pos[turn] += roll(dice)
            if pos[turn] > 10
                pos[turn]= pos[turn] % 10
                if pos[turn] == 0
                    pos[turn] = 10
                end
            end
        end
        score[turn] += pos[turn]

        turn = turn % 2 + 1
        turn_count += 3
    end

    println(score)
    println(turn_count)

    println(score .* turn_count)

end

main()
