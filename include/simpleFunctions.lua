--[[=============================================================================================================================================
-- Filename:	UsefulFunctions.lua
-- Author:		EchoTree
-- Created:		20221110
-- Descrip:		Just a bunch of useful, but simple functions
--============================================================================================================================================--]]

--[[=============================================================================================================================================
--	Name:			NumisNil
--	Author:		EchoTree
--	Date:			20221110
--	Desc:			receives a userinput and decides if input is a valid number (for lua, all number types, floats, integers, etc are considered one type (number))
--	Returns:		A user defined number, if userinput is valid
--============================================================================================================================================--]]
function NumisNil()
	while ( userchoicecondition == nil ) do
		print ( 'Choose a Number: ' )
		local choice = io.read() -- reads user input
		local nchoice = tonumber(choice) -- sets nchoice = to choice with tonumber() if choice is of type(number) nchoice will return with a value, if not, nchoice will be ni
		if(nchoice ~= nil) then -- if nchoice is NOT nil, do some stuff
			gNumber = nchoice
		elseif(nchoice == nil) then -- if nchoice is nil do other stuff
			print(choice..' Is Not a Number\n')
		end
	end
	return gNumber	-- the function will return as the value of number (isNumChoiceNil = gNumber)
end

--[[=============================================================================================================================================
--	Name:			Choice
--	Author:		EchoTree
--	Date:			20221110
--	Desc:			Behaves like CHOICE in batch, but checks to see if a valid input has been given
--	Returns:		
--============================================================================================================================================--]]
function Choice ( choicestring, message )
	local choicetable = {}
		
	for achar = 1, #choicestring do
		local choices = choicestring:sub ( achar, achar )
		table.insert ( choicetable, achar, choices )
	end
	
	while ( userchoicecondition == nil ) do
		if ( message ~= nil or message ~= '' ) then
			print ( message )
		end
		
		local userchoice = io.read():lower()
		for i in ipairs( choicetable ) do
			if ( userchoice:byte() == choicetable[i]:lower():byte() ) then
				userchoicecondition = true
				return userchoice:byte()
			elseif ( i >= #choicetable or userchoice == '' ) then
				print ( userchoice..' is not a valid option, please enter a valid choice' )
				break
			end
		end
	end	
end

-- userchoice = Choice ( 'YNC', 'Choose Yes (Y), No (N), or Cancel (C)' )

--[[=============================================================================================================================================
--	Name:			
--	Author:		
--	Date:			
--	Desc:			
--	Returns:		
--============================================================================================================================================--]]

function fileRead(file, argu)
	local file = io.open(file)
	local contents = file:read( argu )
	file:close()
	return contents
end

--[[=============================================================================================================================================
--	Name:			
--	Author:		
--	Date:			
--	Desc:			
--	Returns:		
--============================================================================================================================================--]]