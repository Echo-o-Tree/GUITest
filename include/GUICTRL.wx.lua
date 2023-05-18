--[[================================================================================
--		Name:			GUITest.lua
--		Author:			EchoTree
--		Date:				20230512
--		Verison:			1.0.1
--		Desc:				A simple lua script to test some wxLua GUI stuff
--		Copyright:	dunno what to put here, use it, don't sell it. ggnore
=================================================================================--]]
--os.execute("mode con:cols=30 lines=1")

local disWidth, disHeight = get_display_size()
print (disWidth..'\n'..disHeight)

local myFrame = wx.wxFrame (wx.NULL, wx.wxID_ANY, 'SCI-FI for AMUMSS', wx.wxDefaultPosition, wx.wxSize( disWidth,disHeight ), wx.wxDEFAULT_FRAME_STYLE+wx.wxTAB_TRAVERSAL )
local myMenuBar = wx.wxMenuBar()
local myFileMenu = wx.wxMenu()
local myViewMenu = wx.wxMenu()
local myHelpMenu = wx.wxMenu()
local icon = wx.wxIcon(gpIncludeFolder..'icon.png', wx.wxBITMAP_TYPE_PNG)
local mySizer1 = wx.wxBoxSizer( wx.wxVERTICAL, myFrame, wx.wxEXPAND | wx.wxALIGN_CENTER )
local mySplitter1 = wx.wxSplitterWindow( myFrame, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxSP_3D |  wx.wxSP_LIVE_UPDATE )
local myPanel1 = wx.wxPanel( mySplitter1, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTAB_TRAVERSAL )
local myPanel2 = wx.wxPanel( mySplitter1, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTAB_TRAVERSAL )

local splitPos = math.floor(disWidth / 8 )
local splitbPos = math.floor( ( disWidth / 8 * 7) / 2 )

local mySizer2  = wx.wxBoxSizer( wx.wxVERTICAL, myPanel1, wx.wxEXPAND | wx.wxALIGN_CENTER )
local mySizer3  = wx.wxBoxSizer( wx.wxVERTICAL, myPanel2, wx.wxEXPAND | wx.wxALIGN_CENTER )

local mySplitter2 = wx.wxSplitterWindow( myPanel2, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxSP_3D |  wx.wxSP_LIVE_UPDATE )

local myPanel3 = wx.wxPanel( mySplitter2, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTAB_TRAVERSAL)
local myPanel4 = wx.wxPanel( mySplitter2, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTAB_TRAVERSAL)

local myText1 = wx.wxStaticText(myPanel1, wx.wxID_ANY, 'Path Tree' )
local myText2 = wx.wxStaticText( myPanel3, wx.wxID_ANY, 'Script Importer UI' )
local myText3 = wx.wxStaticText( myPanel4, wx.wxID_ANY, 'Text CTRL Editor' )




-- these are essentially the main bits that actually make the program run, it essentially works backwards


myPanel1:SetBackgroundColour( wx.wxLIGHT_GREY )
myPanel2:SetBackgroundColour( wx.wxLIGHT_GREY )
myPanel3:SetBackgroundColour( wx.wxLIGHT_GREY )
myPanel4:SetBackgroundColour( wx.wxLIGHT_GREY )

mySplitter2:SplitVertically(myPanel3, myPanel4, splitbPos )
mySizer2:Add( mySplitter2, 1, wx.wxEXPAND, 0 )
myPanel2:SetSizer( mySizer2 )

mySplitter1:SplitVertically( myPanel1, myPanel2, splitPos )
mySplitter1:SetSashPosition( splitPos )
mySizer1:Add( mySplitter1, 1, wx.wxEXPAND, 0 )
myFrame:SetSizer( mySizer1 )

myFileMenu:Append( wx.wxID_ANY, 'N&ew Project', 'Create a New Project' )
myFileMenu:Append( wx.wxID_ANY, 'O&pen Project', 'Open an Existing Project' )
myFileMenu:Append( wx.wxID_ANY, 'S&ave Project', 'Save the Currently Open Project' )
myFileMenu:Append( wx.wxID_ANY, 'C&lose Project', 'Closes the Currently Open Project' )
myFileMenu:Append( wx.wxID_ABOUT, 'A&bout', 'Display some information about the Program' )
myFileMenu:Append( wx.wxID_EXIT, 'E&xit', 'Quit the Program' )


myMenuBar:Append( myFileMenu, '&File' )

myFrame:SetMenuBar( myMenuBar )
myFrame:SetSizeHints( wx.wxDefaultSize, wx.wxDefaultSize )
myFrame:SetIcon(icon)
myFrame:Show( true )
wx.wxGetApp():MainLoop()

--[[ Info about Sizer Windows
declare the var		method 						type			parent			flag		or 			flag					border
local mySizer = wx.wxBoxSizer(wx.wxVERTICAL, myFrame, wx.wxEXPAND | wx.wxALIGN_CENTER, 10)

1. `orientation`: an optional integer that specifies the orientation of the sizer, either `wx.wxHORIZONTAL` or `wx.wxVERTICAL`. The default value is `wx.wxVERTICAL`.
2. `parent`: an optional wxWindow object that will be the parent of the sizer.
3. `flag`: an optional integer that specifies how the sizer should resize with its parent, as well as how its children should be aligned within it. Possible values are:

- `wx.wxEXPAND`: The sizer will resize in both dimensions.
- `wx.wxALIGN_LEFT`: The sizer's children will be left-aligned.
- `wx.wxALIGN_RIGHT`: The sizer's children will be right-aligned.
- `wx.wxALIGN_TOP`: The sizer's children will be top-aligned.
- `wx.wxALIGN_BOTTOM`: The sizer's children will be bottom-aligned.
- `wx.wxALIGN_CENTER`: The sizer's children will be centered.
- `wx.wxALIGN_CENTER_HORIZONTAL`: The sizer's children will be horizontally centered.
- `wx.wxALIGN_CENTER_VERTICAL`: The sizer's children will be vertically centered.

You can combine flags using the bitwise or operator (`|`), for example: `wx.wxEXPAND | wx.wxALIGN_CENTER`.

4. `border`: an optional integer that specifies the border around the sizer. The default value is 0.
5. `userData`: an optional Lua value that can be associated with the sizer.
--]]

--[[ Info about Splitter Windows
local mySplitter = wx.wxSplitterWindow(	parent, id, position, size, style, name)

- `parent`: the parent window object
- `id`: an integer identifier for the window, or `wx.wxID_ANY` to let wxWidgets choose a unique identifier
- `position`: a `wx.wxPoint` object representing the window's position on screen (default is `wx.wxDefaultPosition`)
- `size`: a `wx.wxSize` object representing the window's size (default is `wx.wxDefaultSize`)
- `style`: a bitwise combination of window styles; possible values are:
  - `wx.wxSP_3D`: create a 3D-looking splitter window
  - `wx.wxSP_3DSASH`: create a 3D-looking splitter window with a sash
  - `wx.wxSP_3DBORDER`: create a 3D-looking border around the splitter window
  - `wx.wxSP_LIVE_UPDATE`: update the splitter window while dragging its sash
  - `wx.wxSP_PERMIT_UNSPLIT`: allow the splitter window to be completely unsplitted
  - `wx.wxSP_NOSASH`: create a splitter window without a sash
  - `wx.wxSP_THIN_SASH`: create a splitter window with a thin sash
- `name`: the window name (default is empty)

Note that the `wx.wxSplitterWindow` constructor returns a `wx.wxSplitterWindow` object, which can be used to access the methods and properties of the created window.

--]]

--[[ Info about Panels
wxPanel(wxWindow parent, id, position, size, style, name)

1. `parent` (mandatory) - The parent window that this panel is attached to.
2. `id` (optional) - The ID for this panel. This can be a unique identifier or `wxID_ANY` (the default) to allow wxWidgets to generate a unique ID.
3. `pos` (optional) - The initial position of the panel. The default is `wxDefaultPosition`, which allows the panel to be placed by its parent's sizer.
4. `size` (optional) - The initial size of the panel. The default is `wxDefaultSize`, which allows the panel to be sized by its parent's sizer.
5. `style` (optional) - The style of the panel. The default is `wxTAB_TRAVERSAL`, which allows the panel to be navigated using the TAB key.
6. `name` (optional) - The name of the panel. The default is "panel".
--]]
