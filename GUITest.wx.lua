--[[================================================================================
--		Name:			GUITest.lua
--		Author:		EchoTree
--		Date:			20230512
--		Verison:		1.0.1
--		Desc:			A simple lua script to test some wxLua GUI stuff
--		Copyright:	dunno what to put here, use it, don't sell it. ggnore
--===============================================================================--]]
-- let's start by redefining the package search paths to include our 'include' subdirectory
package.path = package.path..';./include/?.lua'																	-- this one handles where our lua modules are loaded from
package.cpath = package.cpath..';./include/?.dll;./include.?so;'										-- this one handles where dll and/or so are loaded from
--[[
print (package.path)
print (package.cpath)
--]]

-- now we can 'require' our modules/dlls from the include folder, instead of having to deploy them to the lua/bin folder
local wx					= require ( 'wx' )
local sf					= require ( 'simpleFunctions' )
local getOS			= require ( 'getos' )

gpAlpha					= oGetPath()..'\\'
gpIncludeFolder	= gpAlpha..'include\\'
gpVersionFile		= gpIncludeFolder..'version.file'
gVersion				= fileRead(gpVersionFile, '*l' )
gpUpdateFolder	= gpAlpha..'updates\\'
gpCurlFolder		= gpAlpha..'CurlFolder\\'
gpLuaBin				= gpAlpha..'lua\\bin\\'
glua						= gpLuaBin..'lua.exe'

gMode = Choice ( 'DN', 'Would you like to run in (D)ebug mode or (N)ormal mode? ' )
dofileFromSubdirectories( 'updater.lua' )