::=============================================
::	Name:		GUITest.bat
::	Author:	EchoTree
::	Date:		20230513
::	Desc:		A Simple batch script to run a lua script
::	???
::=============================================

@echo off

::Let's set a couple of Global Variables. Here, Globals will start with
::A lowercase 'g' and Global Paths will start with lowercase 'gp'

::here we set the gpAlpha to the current directory that the script is ran from
set gpAlhpa=%cd%

::here we'll set a path to reach the lua bin directory, which should be a subdirectory of our main folder
::then we'll set a var to the path to the actual lua interpreter .exe, so that we can pass it as an executable
set gpLuaBin=%gpAlhpa%\lua\bin
set lua=%gpLuaBin%\lua.exe

::next, we'll call our executable variable, with the name of the script we're trying to run
%lua% GUITest.lua

::finally, we'll pause the batch, so that it doesn't automatically close when the script is done
::pause ::this bit isn't necessary for a GUI