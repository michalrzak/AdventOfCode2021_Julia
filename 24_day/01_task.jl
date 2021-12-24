"""
Here is the ALU defined in the excersise

I ended up solving it by hand, as I needed to analyse the code anyway and the result is a biproduct
"""


function main()
    
    input = open("input.txt")
    instructions = split.(readlines(input), ' ')
    close(input)
    
    final_monad = 0
        
    registers = Dict()
    registers["w"] = 0
    registers["x"] = 0
    registers["y"] = 0
    registers["z"] = 0
    
    for instruction in instructions
        
        if instruction[1] == "inp"
            # skipp
            #registers[instruction[2]] = parse(Int, monad[1])
            #monad = monad[2:end]
            nothing
            
        elseif instruction[1] == "add"
            if instruction[3] in keys(registers)
                registers[instruction[2]] += registers[instruction[3]]
            else
                registers[instruction[2]] += parse(Int, instruction[3])
            end
            
        elseif instruction[1] == "mul"
            if instruction[3] in keys(registers)
                registers[instruction[2]] *= registers[instruction[3]]
            else
                registers[instruction[2]] *= parse(Int, instruction[3])
            end
            
        elseif instruction[1] == "div"
            if instruction[3] in keys(registers)
                registers[instruction[2]] ÷= registers[instruction[3]]
            else
                registers[instruction[2]] ÷= parse(Int, instruction[3])
            end
        
        elseif instruction[1] == "mod"
            if instruction[3] in keys(registers)
                registers[instruction[2]] %= registers[instruction[3]]
            else
                registers[instruction[2]] %= parse(Int, instruction[3])
            end
        
        elseif instruction[1] == "eql"
            if instruction[3] in keys(registers)
                registers[instruction[2]] = registers[instruction[2]] == registers[instruction[3]]
            else
                registers[instruction[2]] = registers[instruction[2]] == parse(Int, instruction[3])
            end
        
        else
            println("error cannot match instruction")
            return
        end
    end
    
    
    println(final_monad)
end

main()
