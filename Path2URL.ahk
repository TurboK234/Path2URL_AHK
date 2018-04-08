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
; It then shows 1) the file that was dropped, 2) the full path, 3) the canonicalized
; version of the file name and 4) the created URL address. The URL address
; can be either manually copy-pasted or copied to clipboard by clicking
; on the button to do it.

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

Gui, New, , Convert local file path to URL
Gui, Font, s8, Courier New
Gui, Add, Text,, Drag and drop a file on this window to create a valid URL link.
Gui, Add, Text,, Dropped file:
Gui, Add, Edit, w480 r1 vFileedit c1212F2 ReadOnly,
Gui, Add, Button,, Copy file name to Clipboard
Gui, Add, Text,, File with full path:
Gui, Add, Edit, w480 r2 vFilepathedit c1212F2 ReadOnly,
Gui, Add, Button,, Copy file path to Clipboard
Gui, Add, Text,, Canonical file name:
Gui, Add, Edit, w480 r1 vFilecanonedit c1212F2 ReadOnly,
Gui, Add, Button,, Copy canonical file name to Clipboard
Gui, Add, Text,, URL link to the file:
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
 SplitPath, filepath, filename, filefolder, fileextension, filebody, filedrive

 GuiControl,, Fileedit, %filename%
 GuiControl,, Filepathedit, %filepath%
 
 VarSetCapacity( returnfilenamecanon, 2000, 0 )
 returnfilenamecanonsz = 2000
 DllCall( "shlwapi\UrlCreateFromPath", Str,filename, Str,returnfilenamecanon, UIntP,returnfilenamecanonsz, UInt,0 )
 filenamecanon := SubStr(returnfilenamecanon, 6 )
 GuiControl,, Filecanonedit, %filenamecanon% 

 VarSetCapacity( fileurl, 2000, 0 )
 urlsz = 2000
 DllCall( "shlwapi\UrlCreateFromPath", Str,filepath, Str,fileurl, UIntP,urlsz, UInt,0 )
 finalurl = %fileurl%
 GuiControl,, Urledit, %finalurl%

 return

ButtonCopyfilenametoClipboard:
 clipboard =	; empty the clipboard first
 clipboard = %filename%
 return
 
ButtonCopyfilepathtoClipboard:
 clipboard =	; empty the clipboard first
 clipboard = %filepath%
 return

ButtonCopycanonicalfilenametoClipboard:
 clipboard =	; empty the clipboard first
 clipboard = %filenamecanon%
 return
 
ButtonCopyURLtoClipboard:
 clipboard =	; empty the clipboard first
 clipboard = %finalurl%
 return

GuiClose:
GuiEscape:
 ExitApp
 
