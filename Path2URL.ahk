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

