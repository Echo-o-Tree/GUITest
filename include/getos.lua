--==============================================================
--	filename:		getos.lua
--	Name:			Get OS platform and Native Commands
--	Author:			EchoTree
--	Date:				11/30/2022
--	Descrip:			A simple script to get your os platform and commands
--==============================================================

gpAlpha = io.popen('cd'):read()
gpLuaBin = gpAlpha..'\\lua\\bin\\'
gpInclude = gpAlpha..'\\include\\'
gpLuaInt = gpLuaBin..'lua.exe'
gpWXLuaInt = gpLuaBin..'wxLua.exe'
gpCurlFolder = gpAlpha..'MBINCompilerDownloader\\'
gpCurlEXE = gpCurlFolder..'curl.exe'

function oGet()																							-- Method "Get" for oSystem
    local envMacOS = 'CI_PRODUCT_PLATFORM'													-- Environment variable for macos
    local envLinuxOS = 'DESKTOP_SESSION'															-- Environment variable for LinuxOS
    local envWindowsOS = 'OS'																				-- Environment variable for Windows OS
    if(os.getenv(envMacOS) == 'macOS') then														-- Tries the env var for MacOS first, if it's not mac, then
        print('Using MacOS')
        osPlatform = 'macOS'
    elseif(os.getenv(envLinuxOS) == not('gnome' or 'ubuntu')) then				-- tries several different distros for linux, if it returns nil, you will have to add your distro's desktop_session value
        print('Using Linux OS')
        osPlatform = 'Linux'
    elseif(os.getenv(envWindowsOS) == 'Windows_NT') then							-- tries the env var for windows
        -- print('Using Windows OS')
        osPlatform = 'Windows'
    end
    return osPlatform
end

osPlatform = oGet()																					-- sets the osPlatform var equal to the result returned by the oSystem:Get() method
if(osPlatform == 'Windows') then																			-- checks if the platform is windows
	Echo = 'echo '																										-- sets the var Echo to the os print cmd
	Deldir = 'rd '																											-- sets the var Deldir to the os Remove Directory cmd
	Dir = 'dir '
	IfNotExist = 'if not exist '
	Mkdir = ' mkdir '																									-- sets the var Mkdir to the os Make Directory cmd
	Pause = 'pause'																									-- sets the var Pause to the os pause cmd
	Ping = 'ping '																											-- sets the var Ping to the os Ping cmd
	Start = 'start '																										-- sets the var Start to the os start cmd
	Wait = 'timeout /t '																								-- you get the point lol
--[[																																-- uncomment this line to add the linux commands. note, you'll have to add the cmds in yourself
elseif(osPlatform == 'Linux') then																			-- checks if the platform is Linux
	Start = ' '
	Pause = ' '
	Mkdir = ' '
	Deldir = ' '
	Echo = ' '
	Ping = ' '
	IfNotExist = ' '
--]]
--[[																																-- uncomment this line to add macos commands
elseif(osPlatform == 'macOS')																				-- checks if the platform is macOS
	Start = ' '
	Pause = ' '
	Mkdir = ' '
	Deldir = ' '
	Echo = ' '
	Ping = ' '
	IfNotExist = ' '
--]]
--[[
else																																
	Start = ' '
	Pause = ' '
	Mkdir = ' '
	Deldir = ' '
	Echo = ' '
	Ping = ' '
	IfNotExist = ' '
--]]
end

function oStart(application)
	os.execute(Start..application)																			-- Takes a single input (application) and starts it from the cmd line. 
end

function oPause()
	os.execute(Pause)																								-- is pause, but in lua
end

function oMkdir(makedirectory)
	os.execute(IfNotExist..makedirectory..Mkdir..makedirectory)					-- checks if a directory exists, and, if it doesnt, makes it
end

function oDeldir(deldirectory)
	os.execute(Deldir..deldirectory)																		-- delets the specified directory. DO NOT USE ON SYSTEM FILES
end

function oPing(pingable)
	os.execute(Ping..pingable)																				-- Pings stuff
end

function oEcho(printable)
	os.execute(Echo..printable)																			-- it's Echo, but cross platform
end

function oWait(seconds)
	os.execute(Wait..' '..seconds)																			-- timeout with interuptable countdown
end

function oGetPath()
	lpath = io.popen('cd'):read()
	return lpath
end

function olua(luascript)
	os.execute(gpLuaInt..' '..luascript)																	-- Runs a lua script from the included 5.4.4 lua interpreter. you can set your own interpreter above
end

function owxLua(wxluascript)
	os.execute(gpWXLuaInt..' '..wxluascript)														-- same as above but runs the script through the wxLua interpreter.
end

--[[=============================================================================================================================================
--	Name:			dofileFromSubdirectories
--	Author:			EchoTree
--	Date:				20230516
--	Desc:				Searches through all subdirectories of a given parent directory for a file, then if found, executes the file.
--	Returns:		A file path for the desired file, if it finds one, or 
--============================================================================================================================================--]]

function dofileFromSubdirectories(filename)
    local function searchSubdirectories(directory)
        for entry in io.popen(Dir..' "' .. directory .. '" /b /ad'):lines() do																			-- executes the platform's 'Directory' command to list all of the contents of the selected directory. (/b)are lists only the names, (/ad) lists only directories
            local subdir = directory .. '/' .. entry																													-- assigns each subdirectory as a path
            local filepath = subdir .. '/' .. filename																											-- affixes the above path with the file we're looking for
            local file = io.open(filepath, 'r')																															-- attempts to open the filepath, in the 'r'ead state
            if file then																																								-- if the file is found, 'file' will be assigned a non-nil value, making the statement 'true'. if the file can't be found, 'file' will be nil, and the statement will return false
                file:close()																																						-- closes the file we 'opened'  above
                return filepath																																					-- returns the filepath for use
            end
            if entry ~= '.' and entry ~= '..' then																													-- checks to make sure the current and parent subdirectories aren't being processed
                local found = searchSubdirectories(subdir)																								-- starts to search subdirectories of the current subdirectory
                if found then																																						-- if we find the desired file, 'found' will be assigned a value, making the statement 'true'. if we don't, 'found' will remain 'nil' and the statement will return false
                    return found																																					-- returns the filepath for use
                end
            end
        end
    end

    local filePath = searchSubdirectories('.')																												-- uses the above nested function to search the subdirs within the current directory
    if filePath then																																							-- if the function returns a filepath,'filePath' will be assigned a value, making the statement 'true'. if we don't, 'filePath' will remain 'nil' and the statement will return false
        return dofile(filePath)
    else
        return 'Failed to find and execute file: '.. filename
    end
end

--[[
osc:Start('calc.exe') 										-- starts the executable file
osc:Echo('Hello World')									-- echos the text on the cmdline
osc:Pause()														-- pauses
--osc:Mkdir('c:\\New\\filepath\\here') 	--	creates a new directory if it doesn't already exist
--osc:Deldir('c:\\New\\filepath\\here')		-- deletes a directory. DO NOT USE ON SYSTEM32!!!!!!!!!!!!!!
osc:Ping('192.168.1.1')									-- pings the selected address
osc:Wait(60)													-- waitaminute
--]]

--[[=============================================================================================================================================
--	Name:			
--	Author:		EchoTree
--	Date:			20230516
--	Desc:
--	Returns:
--============================================================================================================================================--]]

function get_display_size()
	local handle = io.popen( 'wmic path Win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution')
	local output = handle:read("*all")
	handle:close()

	local width, height = string.match(output, "(%d+)%s+(%d+)")
	width = tonumber(width)
	height = tonumber(height) - 100
  return width, height
end

--[[=============================================================================================================================================
--	Name:			
--	Author:		EchoTree
--	Date:			20230516
--	Desc:
--	Returns:
--============================================================================================================================================--]]