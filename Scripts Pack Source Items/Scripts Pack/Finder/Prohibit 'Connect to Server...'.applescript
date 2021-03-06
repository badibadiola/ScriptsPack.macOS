# Scripts Pack - Tweak various preference variables in macOS
# <Phorofor, https://github.com/Phorofor/>

-- Restrict 'Connect to Server…' Menu Item
-- Versions compatible:
-- Preference Identifier: com.apple.finder
-- Preference Keys: ProhibitConnectTo
-- Preference location: ~/Library/Preferences/com.apple.finder.plist
-- Default value (boolean): false

set useR to do shell script "whoami"
set toggleBut to "Restrict"
set tZ to "Restrict"
set sTz to "true"
set bT to "You've set the Finder to restrict the 'Connect to Server...' menu item for " & useR & "."

try
	set prValue to do shell script "defaults read com.apple.finder ProhibitConnectTo"
	if prValue = "1" then
		set prValue to "The 'Conect to Server…' function in Finder is currently restricted. You cannot use the hotkeys for it too."
		set toggleBut to "Allow 'Connect to Server...'"
		set tZ to "Allow"
		set sTz to "false"
		set bT to "You've set the Finder to allow access to the 'Connect to Server...' menu item for " & useR & "."
	else
		set prValue to "The 'Connect to Server...' function in Finder is currently enabled. There are no restrictions currently set for this feature."
	end if
on error
	set prValue to "The 'Connect to Server...' menu item is enabled by default."
end try
display alert tZ & " the Finder 'Connect to Server...' menu item for " & useR & "?" message "Restricting the menu item will prevent the user from being able to access it even with the hotkeys. (⌘K)" & return & return & prValue buttons {"Cancel", "Clear", toggleBut} default button 3 cancel button 1
if the button returned of the result is toggleBut then
	do shell script "defaults write com.apple.finder ProhibitConnectTo -bool " & sTz
else
	do shell script "defaults delete com.apple.finder ProhibitConnectTo"
	set bT to "You've decided to clear the preference."
end if
tell application "System Events" to (name of every process)
if the result contains "Finder" then
	tell application "Finder"
		display alert "Restart needed for changes to take effect." message bT & " In order to see your changes, you'll need to restart the Finder. You can choose to restart it later if you wish to." buttons ["Restart Later", "Restart Now"] cancel button 1 default button 2
	end tell
	do shell script "killall Finder"
else
	display alert "Finder - Changes Applied!" message bT & ". You'll be able to see your changes the next time you run Finder."
end if
end