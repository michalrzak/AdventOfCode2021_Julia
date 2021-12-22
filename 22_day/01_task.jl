
function main()

    points = Dict{Tuple{Int64, Int64, Int64}, Bool}()

    for line in eachline("input.txt")
        x_s, y_s, z_s = split(split(line, ' ')[2], ',')

        x = parse.(Int, split(x_s[3:end], ".."))
        y = parse.(Int, split(y_s[3:end], ".."))
        z = parse.(Int, split(z_s[3:end], ".."))

        ranges = [x, y, z]

        out_of_range = false

        for range in ranges
            if range[1] < -50 || range[2] > 50
                out_of_range = true
                break
            end
        end
        
        if out_of_range
            continue
        end

        for ix in x[1]:x[2]
            for iy in y[1]:y[2]
                for iz in z[1]:z[2]
                    points[(ix, iy, iz)] = line[1:2] == "on"
                end
            end
        end

    end

    println(count(x -> x[2], points))

end

main()
