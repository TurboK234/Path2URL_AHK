# Path2URL_AHK
AutoHotkey script (with GUI window) to convert a filename (with path) to a canonical URL

This script was created to easily create URL addresses from local files. The original need for this came from a html5 based program I use to create diagrams. The diagrams can have hyperlinks either to other pages in the same diagram OR to URL's, but NOT local files (which could cause problems when converting the diagram to html, anyway). I needed a way to easily create valid URL links for my local files and this small GUI window serves the purpose.

The script creates a GUI window that waits for a file to be dragged onto it. It then shows 1) the file that was dropped, 2) the full path, 3) the canonicalized version of the file name and 4) the created URL address. The URL address can be either manually copy-pasted or copied to clipboard by clicking on the button to do it.


The core of the script uses Shell Lightweight Utility Functions (i.e. shlwapi.dll), which is a built-in property of Windows. 
