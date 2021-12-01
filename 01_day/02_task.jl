
function solve()
	input = open("input.txt")
	meassurments = parse.(Int, readlines(input))
	close(input)

	previous = meassurments[1]
	counter = 0

	skip = true
	for i = 1:length(meassurments) - 2

		elem = 0
		for j = 0:2
			elem += meassurments[i+j]
		end


		if (!skip && elem > previous)
			counter += 1
		end
		skip = false
		previous = elem
	end

	println(counter)
end

solve()