
function solve()
	input = open("input.txt")
	meassurments = parse.(Int, readlines(input))
	close(input)

	previous = meassurments[1]
	counter = 0
	for elem in meassurments
		elem_num = elem
		if (elem_num > previous)
			counter += 1
		end
		previous = elem_num
	end

	println(counter)
end

solve()