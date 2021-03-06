# Scripts Pack - Tweak various preference variables in macOS
# <Phorofor, https://github.com/Phorofor/>

-- Launchpad Animation Duration
-- Version compatible: Mac OS X Lion (10.7)+
-- Preference Identifier: com.apple.dock
-- Preference Key: springboard-hide-duration, springboard-show-duration
-- Preference location: ~/Library/Preferences/com.apple.dock.plist
-- Default value (integer): -- 

set MacVer to do shell script "sw_vers -productVersion"
set MacVer to "10.7.0"
set Min to "10.7.0" as string
if MacVer < Min then
	display alert "Outdated Mac OS Version!" message "You're using Mac OS " & MacVer & ". This script will only work properly with Mac OS Lion (10.7) and later. You cannot use this feature at this time. Update your system so you can use this feature." buttons ["OK", "More Information"] as warning cancel button 1
	do shell script "open http://support.apple.com/kb/SP629"
	error number -128
end if


set defaultHD to (get path to applications folder)
set mcIcon to defaultHD & "Launchpad.app:Contents:Resources:Launchpad.icns" as string
try
	set prValue to do shell script "defaults read com.apple.dock springboard-show-duration"
	set p6Value to return & "🔲 Show Animation Speed: " & prValue
on error
	set p6Value to return & "🔳 Undefined Show Animation Speed"
end try
try
	set p1Value to do shell script "defaults read com.apple.dock springboard-hide-duration -int"
	set p2Value to return & "🔲 Hide Animation Speed: " & p1Value
on error
	set p2Value to return & "🔳 Undefined Hide Animation Speed"
end try
display alert "Would you like to set the launchpad fade & open animation?" message "You can clear the settings and return to its defaults by clicking the 'Clear' action. You can set the animations to your liking by clicking 'Set Animation Speeds'" & return & p6Value & p2Value buttons {"Cancel", "Clear", "Set Animation Speeds"} cancel button 1 default button 3
if the button returned of the result is "Clear" then
	do shell script "defaults delete com.apple.dock springboard-show-duration"
else
	set tD to display dialog "Enter a value to set for the fade or open animation of the Launchpad. You can set it to whatever you like if you want to. Set it to 0 for no animation. You can also use decimals." buttons ["Cancel", "Set for Hide", "Set for Show"] cancel button 1 with title "Set Animation Speeds" default answer "Enter a value in seconds…" with icon file mcIcon
	set p3Value to (text returned of tD) as number
	if the button returned of the tD is 3 then
		try
			set pValue to (text returned of tD) as number
		on error
			display alert "An Expected Error Occured: Invalid Value" message "Please only use numbers. The characters: 1234567890. is only allowed to be used." buttons ["OK"] cancel button 1 default button 1
		end try
	end if
end if
if the button returned of the tD is "Set for Show" then
	do shell script "defaults write com.apple.dock springboard-show-duration -int " & p3Value
else
	do shell script "defaults write com.apple.dock springboard-hide-duration -int " & p3Value
	
end if
tell application "System Events"
	display alert "Restart for changes to take effect." message "In order for your changes to take effect, you need to restart the Dock. Would you like to do that now?" buttons ["Don't Restart", "Restart Dock"] cancel button 1 default button 2
end tell
do shell script "killall Dock"
(*	delay 2.5
	tell application "Dock"
		display alert "Your changes should be saved and have been taken effect." 
	end tell
	*)
end