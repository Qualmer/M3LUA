_G['boardWidth'] = 10
_G['boardHeight'] = 10
_G['countToMatch'] = 3

local board = {}
local elements = {'A', 'B', 'C', 'D', 'E', 'F'}
local matches = {}

function board.Init()
	board.Mix()
end

function board.Tick()
	_G['tick'] = _G['tick'] + 1
end

function board.Move(from, to)
	local temp = board[to.y][to.x]
	board[to.y][to.x] = board[from.y][from.x]
	board[from.y][from.x] = temp
end

function board.Mix()
	for i=1,_G['boardHeight'] do
		board[i] = {}    
		for j=1,_G['boardWidth'] do
			local elementsToExclude = {}
			local newElement = GetRandomElementExclude(nil)
			while i>2 and board[i-1][j] == newElement and board[i-2][j] == newElement or
			j>2 and board[i][j-1] == newElement and board[i][j-2] == newElement do
				table.insert(elementsToExclude, newElement)
				newElement = GetRandomElementExclude(elementsToExclude)
			end
			board[i][j] = newElement
		end
	end
end

function board.Dump()
	table.sort(matches, function (a, b) return a.y < b.y end)
	for i =1, #matches do
		X = matches[i].x
		Y = matches[i].y
		while Y > 1 do
			local temp = board[Y][X]
			board[Y][X] = board[Y-1][X]
			board[Y-1][X] = temp
			Y = Y - 1
		end
		board[Y][X] = elements[math.random(#elements)]
	end
	_G['score'] = _G['score'] + #matches
	matches = {}
end

function board.GetMatches()
	if #matches == 0 then
		matches = board.SearchMatches()
	end
	return matches
end

function board.SearchMatches()
	local score = 0
	local matchedCells = {}
	--горизонтально
	for i = 1, _G['boardHeight'] do
		local tempCells = {x = 0, y = i}
		local tempElement = board[i][1]
		for j = 1, _G['boardWidth'] do
			local stop = false
			local currentCell = board[i][j]
			if j > 1 and currentCell == tempElement then
				table.insert(tempCells, {x = j,y = i})
			else
				stop = true	
			end
			if stop or j == _G['boardWidth'] then
				if #tempCells >= _G['countToMatch'] then
					for key, cell in pairs(tempCells) do
						table.insert(matchedCells, cell)
					end
				end
				tempCells = {{x = j,y = i}}
				tempElement = currentCell
			end
		end
	end
	--вертикально
	for j = 1, _G['boardWidth'] do
		local tempCells = {x = j, y = 0}
		local tempElement = board[1][j]
		for i = 1, _G['boardHeight'] do
			local stop = false
			if i > 1 and board[i][j] == tempElement then
				table.insert(tempCells, {x = j, y = i})
			else
				stop = true	
			end
			if stop or i == _G['boardHeight'] then
				if #tempCells >= _G['countToMatch'] then
					for key, cell in pairs(tempCells) do
						table.insert(matchedCells, cell)
					end
				end
				tempCells = {{x = j,y = i}}
				tempElement = board[i][j]
			end
		end
	end
	matches = matchedCells
	return matchedCells
end

function GetRandomElementExclude(exclude)
	local index = math.random(#elements)
	while(elements[index] == exclude) do
		index = math.random(#elements)
	end
	return elements[index]
end
return board