local Output = require ('Output')
local Input = require('Input')
local Board = require('BoardModel')

math.randomseed(os.time())
Board.Init()
Output.ShowStartScreen()
io.read()
Output.ShowGameScreen(Board)

while true do
	from, to, isExit = Input.GetInput()
	if isExit then
		break 
	end
	if from == nil or to == nil then
		_G['message'] = "Invalid input"
		goto continue
	end
	
	Board.Move(from, to)
	Board.Tick()
	_G['moves'] = _G['moves'] + 1
	Output.ShowGameScreen(Board)
	if #Board.GetMatches() > 0 then
		Board.Dump()
		Board.Tick()
		_G['message'] = "OK"
	else
		Board.Move(from, to)
		Board.Tick()
		_G['message'] = "No match."
	end
	::continue::
	Output.ShowGameScreen(Board)
end

Output.ShowExitScreen()