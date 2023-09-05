local inputController = {}

function inputController.GetInput()
	local line = io.read()
	if line == 'q' or line == "Q" then 
		return nil, nil, true 
	end
	
	local commands = Split(line)
	if IsInvalid(commands) then
		return nil, nil, false
	end  
  
	local from = {x=tonumber(commands[2]) + 1, y=tonumber(commands[3]) + 1}
	local to = GetTargetCoordanates(from, commands[4])

	return from, to, false
end

function Split(line)
    result = {}
    for match in (line..' '):gmatch("(.-)"..' ') do
        table.insert(result, match)
    end
    return result
end

function GetTargetCoordanates(from, direction)
	local result = {x = from.x, y = from.y}
	if direction == 'u' and from.y > 1 then
		result.y = from.y - 1  
	elseif direction == 'l' and from.x > 1 then
		result.x = from.x - 1  
	elseif direction == 'r' and from.x < _G['boardWidth'] - 1 then
		result.x = from.x + 1  
	elseif direction == 'd' and from.y < _G['boardHeight'] - 1 then
		result.y = from.y + 1
	else
		return nil
	end  
	return result
end

function IsInvalid(commands)
    return (#commands ~=4 or commands[1] ~= 'm' 
    or tonumber(commands[2]) < 0 or tonumber(commands[2]) > _G['boardWidth'] - 1
    or tonumber(commands[3]) < 0 or tonumber(commands[3]) > _G['boardHeight'] - 1
	or (string.match("urld", commands[4]) == nil))
end  

return inputController