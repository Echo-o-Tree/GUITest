--[[================================================================================
--		Name:			FullTest.lua
--		Author:		EchoTree
--		Date:			20230512
--		Verison:		1.0.1
--		Desc:			A simple lua script to pull info from github using some weird shit tbh
--		Copyright:	dunno what to put here, use it, don't sell it. ggnore
--===============================================================================--]]

-- Import the wxLua module
local wx = require("wx")

-- Let's preload a couple of handy files I've made
require ( 'getos' )
require ( 'simpleFunctions' )

-- Let's set our Mode of Operation. We'll use gMode to decide whether some features should be available or not
-- D or d will have a byte value of 100, N or n will have a byte value of 110.
gMode = Choice( 'DN', 'Choose Mode of Operation, (D)ebug or (N)ormal.' ):lower():byte()
if ( gMode == 100 ) then
	print ( 'Debug Features Enabled!' )
end

-- Now let's define some global variables, Global variables will be prefixed with a lowercase 'g'. Path Variables will be prefixed with a 'gp'.

gpAlpha						=		io.popen('cd'):read()							-- This is the main directory that the script will be run from, bia batch (.bat) file
gpUpdateFolder		=		gpAlpha..'\\updates'						--	This is the updates subdirectory under the 'Alpha' directory
gpIncludeFolder		=		gpAlpha..'\\include'						--	This is the include subdirectory under the 'Alpha' directory, besides the main lua folder, this one will hold most of the helper scripts
gpVersionFile			=		gpIncludeFolder..'\\version.file'	--	This is the path to the version file, which will be used to check the script versions
gpCurlFolder 			=		gpAlpha..'\\CurlFolder\\'				-- The subdirectory that houses the curl.exe
gpCurlEXE 					=		gpCurlFolder..'curl.exe'					-- The actual curl.exe

gVersion					=		io.open( gpVersionFile ):read( '*l' )

if ( gMode == 100 ) then
	print ( 'Alpha Directory: '..gpAlpha )
	print ( 'Update Folder: '..gpUpdateFolder )
	print ( 'Include Folder: '..gpIncludeFolder )
	print ( 'Version Filepath: '..gpVersionFile )
	print ( 'Curl Folder: '..gpCurlFolder )
	print ( 'curl.exe Path: '..gpCurlEXE )
	print ( 'Version No: v'..gVersion )
end

dofile ( gpIncludeFolder..'\\updater.lua' )


local app = wx.wxApp()																																													-- Create an application object

local frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, "GUI Test", wx.wxDefaultPosition, wx.wxSize(400, 300))									-- Create a frame (window)

frame:Show(true)																																																-- Show the frame

app:MainLoop()																																																-- Start the application main loop