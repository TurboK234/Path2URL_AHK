; Path2URL - AutoHotkey script to convert file paths to URL
; Copyright (c) 2016 Henrik Söderström
; This script is published under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) licence.
; You are free to use the script as you please, even commercially, but you should publish the edited code
; under the same licence and give the original creator appropriate credit. More information about the licence
; can be found at http://creativecommons.org/licenses/by-sa/4.0/ .

; This script was created to easily create URL addresses from local files.
; The original need for this came from a html5 based program I use to create
; diagrams. The diagrams can have hyperlinks either to other pages in the
; same diagram OR to URL's, but NOT local files (which could cause problems
; when converting the diagram to html, anyway). I needed a way to easily
; create valid URL links for my local files and this small GUI window serves
; the purpose.

; The script creates a GUI window that waits for a file to be dragged onto it.
; It then shows 1) the file that was dropped with its full path and 2) the
; created canonical URL address. The URL address can be either manually
; copy-pasted or copied to clipboard by clicking on the button to do it.

; The core of the script uses Shell Lightweight Utility Functions (i.e. shlwapi.dll),
; which is a built-in property of Windows. 

; -----
; GENERAL SETUP, DON'T EDIT, COMMENTS PROVIDED FOR CLARIFICATION.
SendMode, Input                         ; Recommended for new scripts due to its superior speed and reliability.
#NoEnv                                  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance FORCE                   ; There can be only one instance of this script running.
#NoTrayIcon                             ; This script should behave as much as a normal GUI program, no tray needed.
SetWorkingDir, %A_ScriptDir%            ; Ensures a consistent starting directory.
StringCaseSense, On                     ; Turns on case-sensitivity.
FileEncoding, UTF-8                     ; The default encoding is UTF-8, since it seems to be most compatible.

EnvGet, Env_Path, Path
filepath =
fileurl =
finalurl =

Gui, New, , Convert local file path to URL
Gui, Font, s8, Courier New
Gui, Add, Text,, Drag and drop the file on this Window to create a valid URL link.
Gui, Add, Text,, Dropped file:
Gui, Add, Edit, w480 r2 vFileedit c1212F2 ReadOnly,
Gui, Add, Text,, URL link for the file:
Gui, Add, Edit, w480 r4 vUrledit c1212F2 ReadOnly,
Gui, Add, Button, Default, Copy URL to Clipboard
Gui, Show
return

GuiDropFiles:
 Loop, Parse, A_GuiEvent, `n
 {
	firstfile = %A_LoopField%
	Break
 }
 filepath = %firstfile%

 GuiControl,, Fileedit, %filepath%
 VarSetCapacity( fileurl, 2000, 0 )
 DllCall( "shlwapi\UrlCreateFromPath", Str,filepath, Str,fileurl, UIntP,2000, Str,"NULL" )
 finalurl = %fileurl%
 fileurl =
 GuiControl,, Urledit, %finalurl%
 return
 
ButtonCopyURLtoClipboard:
 clipboard =	; empty the clipboard firstfile
 clipboard = %finalurl%
 return

GuiClose:
GuiEscape:
 ExitApp
