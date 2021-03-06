# Scripts Pack - Tweak various preference variables in macOS
# <Phorofor, https://github.com/Phorofor/>

-- Displays notification in Dock each time the track is changed in the iTunes application. It will always pop up even if the iTunes window is showing. No longer works in recent versions of iTunes or macOS.

-- Show iTunes Song Notification for the Dock.

-- Versions compatible: Mac OS X Lion (10.7)+
-- Preference Identifier: com.apple.dock
-- Preference Key: itunes-notifications
-- Preference location: ~/Library/Preferences/com.apple.dock.plist
-- Default value (boolean): false

set MacVer to do shell script "sw_vers -productVersion"
set Min to "10.7.0" as string
if MacVer < Min then
	display alert "Outdated Mac OS Version!" message "You're using Mac OS " & MacVer & ". This script will only work properly with Mac OS Lion (10.7) and later. This script will not work as expected for your current version. Please update for in order for this feature to work!" buttons ["OK", "More Information"] as warning cancel button 1
	do shell script "open http://support.apple.com/kb/SP629"
else
	set toggleBut to "Enable"
	set tZ to "enable"
	set sTz to "YES"
	set bT to "You've enabled iTunes Song Notifications in the Dock."
	try
		set prValue to do shell script "defaults read com.apple.dock itunes-notifications -bool"
		if prValue = "1" then
			set psValue to "🔲 iTunes Song Notifications is currently enabled. Notifications will appear in the Dock when a track is being played."
			set toggleBut to "Disable"
			set tZ to "disable"
			set sTz to "YES"
			set bT to "You've enabled iTunes Song Notifications in the Dock."
		else
			set psValue to "🔴 iTunes Song Notifications is currently disabled. Notifications will not appear in the Dock when a song is being played."
		end if
	on error
		set psValue to "🔳 iTunes Song Notifications in the Dock is disabled by default."
	end try
	display alert "Would you like to " & tZ & " Song notifications for iTunes?" message "Notifications will appear in the Dock when a track is changed or being played in iTunes." & return & return & psValue buttons {"Cancel", "Clear", toggleBut} default button 3 cancel button 1
	if the button returned of the result is toggleBut then
		do shell script "defaults write com.apple.dock itunes-notifications -bool " & sTz
	else
		-- Delete iTunes Notification Preferences and Disable (default setting)
		do shell script "defaults delete com.apple.dock itunes-notifications"
	end if
	tell application "System Events" to (name of every process)
	if the result contains "Dock" or "iTunes" then
		tell application "Dock"
			display alert "Dock & iTunes - Restart to see changes." message "The Dock needs to be restarted in order for your changes to take effect. Restart the Dock now? If iTunes is opened, you'll need to reopen it manually." buttons {"Don't Restart", "Restart Dock"} cancel button 1 default button 2
			do shell script "killall Dock"
		end tell
	else
		display dialog "You'll be able to see the changes the next time the Dock and iTunes is running"
	end if
end if