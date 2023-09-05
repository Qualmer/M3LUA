local ui = {}

_G['message'] = "OK"
_G['score'] = 0
_G['moves'] = 0
_G['tick'] = 0

local function AddIndent()
	print("\n████████████████████████████████████████████████████\n")	
end

function ui.ShowGameScreen(board)
	AddIndent()
	print("State: " .. _G['message'])  
	print("Tick: " .. _G['tick'])
	print("Moves: " .. _G['moves'])
	print("Score: " .. _G['score'])
	print("")
	print("   0 1 2 3 4 5 6 7 8 9")
	print("   -------------------")
	for i=1, _G['boardWidth'] do
		print(i-1 .. "| " .. table.concat(board[i], " ") .. " |" .. i-1)
	end  
	print("   -------------------")
	print("   0 1 2 3 4 5 6 7 8 9")
end

function ui.ShowStartScreen()
	AddIndent()
	print("		Welcome to Match 3 game!") 
	print("		  Press Enter to start")
end

function ui.ShowExitScreen()
	AddIndent()
	print("					█═══GAME═══██════OVER════█")
	AddIndent()
end
return ui