function solve()
	
	x = 0
	y = 0
	aim = 0

	for line in eachline("input.txt")
		split_line = split(line, " ")

		command = split_line[1]
		ammount = parse(Int, split_line[2])

		if command == "forward"
			x += ammount
			y += aim * ammount
		elseif command == "down"
			aim += ammount
		elseif command == "up"
			aim -= ammount
		end
	end

	println(x * y)


end

solve()