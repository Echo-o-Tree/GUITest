--[[================================================================================
--		Name:				Updater.lua
--		Author:			EchoTree
--		Date:				20230512
--		Verison:			1.0.0
--		Desc:				A simple lua script to pull info from github using some weird shit tbh
--		Copyright:		dunno what to put here, use it, don't sell it. ggnore
--===============================================================================--]]

-- This file is designed to run from a dofile command in a parent script. Because of this, I can skip re-declaring some of the global
-- Variables set in the parent script. For an example, you can un-comment the next line to see how it behaves.
--print ( 'Running updater.lua...\nThe Parent Directory  (gpAlpha) is: '..gpAlpha )

-- Some debug options to check the paths the updater is using
print ( 'Running updater.lua' )
if ( gMode == 100 ) then
	print ( 'Alpha Directory: '..gpAlpha )
	print ( 'Update Folder: '..gpUpdateFolder )
	print ( 'Include Folder: '..gpIncludeFolder )
	print ( 'Version Filepath: '..gpVersionFile )
	print ( 'Curl Folder: '..gpCurlFolder )
	print ( 'curl.exe Path: '..gpCurlEXE )
	print ( 'Version No: v'..gVersion )
end

--lets do a simple check to see if the 'update' directory is present. If not, lets make one.
os.execute( 'if not exist '..gpUpdateFolder..' mkdir '..gpUpdateFolder)

local scriptname			=	'GUITest.lua'
local username				=	'Echo-o-Tree'
local repo						=	'GUITest'
local branch					=	'main'
local github_url			=	'https://raw.githubusercontent.com/'..username..'/'..repo..'/'..branch..'/'..scriptname
local gh_api_url			=	'https://api.github.com/repos/'..username..'/'..repo..'/releases/latest'
local download_url		=	gh_api_url
local curlcmd 				=	'curl -Ls '..download_url

if ( gMode == 100 ) then
	print ( 'Script Name: '..scriptname )
	print ( 'Username: '..username )
	print ( 'Repository: '..repo )
	print ( 'Branch: '..branch )
	print ( 'GitHub URL: '..github_url )
	print ( 'GitHub API URL: '..gh_api_url )
	print ( 'Download URL: '..download_url )
	print ( 'curl Command: '..curlcmd )
end

local handle = io.popen(curlcmd)
local output = handle:read( '*a' )
handle:close()

local start_pos, end_pos = output:find( '"browser_download_url"%s-:%s-"(.-)"' )
local real_url
if ( start_pos and end_pos ) then
	real_url = output:match('"browser_download_url"%s-:%s-"(.-)"')
	real_url = real_url:gsub("\\/", "/")
	if ( gMode == 100 ) then
		print("Download URL:", real_url)
	end
	real_url = real_url:gsub(".bat", ".lua") -- replace .bat with .lua
	curlcmd = 'curl -Ls '..real_url..' >'..gpUpdateFolder..'\\new_'..scriptname
	if ( gMode == 100 ) then
		print ( 'New curl Command: '..curlcmd )
	end
else
	print( 'Could not find download URL in response' )
	if ( gMode == 100 ) then
		print ( 'Response: \n'..output )
	end
end

local remversion = real_url:match('/(%d+%.%d+%.%d+)/')
if ( gMode == 100 ) then
	print ( remversion )
end

local function split_version(remversion)
  local parts = {}
  for part in string.gmatch(remversion, "%d+") do
    table.insert(parts, tonumber(part))
  end
  return parts
end

local version_rem = remversion
local version_current = gVersion
local parts1 = split_version(remversion)
local parts2 = split_version(gVersion)

for i = 1, 3 do
	if parts1[i] < parts2[i] then
		print('Remote Version: v'..remversion..' is older than Client Version: v'..gVersion)
	break
	elseif parts1[i] > parts2[i] then
		print('Remote Version: v'..remversion..' is newer than Client Version: v'..gVersion)
		
		local gh_zip_url = 'https://github.com/'..username..'/'..repo..'/archive/refs/heads/'..branch..'.zip'										-- Download the entire repository as a .zip file
		local curlcmd_zip = 'curl -Ls '..gh_zip_url..' >'..gpUpdateFolder..'\\GUITest.zip'																					--
		os.execute(curlcmd_zip)																																											--
		
		local tempdir = gpAlpha..'\\temp'																																							-- Extract the files to a temporary directory
		os.execute('if not exist '..tempdir..' mkdir '..tempdir)																														--
		print ( 'Extracting Files' )
		os.execute('powershell Expand-Archive -Path '..gpUpdateFolder..'\\GUITest.zip -DestinationPath '..tempdir..' -Force')		--

		os.execute('powershell Move-Item -Force '..tempdir..'\\'..repo..'-main\\* '..gpAlpha..'\\')														-- Move the files to the Parent Directory

		local file = io.open(gpVersionFile, 'w' )																																					-- Open the file for writing
		file:write( remversion )																																											-- Write the version number to the file
		file:close()																																																-- Close the file
		
		os.execute('rmdir /s /q '..tempdir)																																							-- Remove the temporary directory
		break
	elseif i == 3 then
		print('Remote Version: v'..remversion..' is the same as Client Version: v'..gVersion)
	end
end