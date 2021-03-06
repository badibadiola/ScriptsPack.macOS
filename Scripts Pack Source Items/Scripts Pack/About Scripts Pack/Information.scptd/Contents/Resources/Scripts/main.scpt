# Scripts Pack - Tweak various preference variables in macOS
# <Phorofor, https://github.com/Phorofor/>

-- This is actually in .applescript plain text format
-- You must edit this through this bundle's package contents
-- and change the extension to .applescript in order to save

(*
display alert "View Information?" message "You can view the main information resources from the Scripts Pack and other information you might need to know or incase you've deleted the original disk image." buttons ["Cancel", "Open"] cancel button 1 default button 2
*)

set s1 to (((path to me) as text) & "Information")
set s1 to POSIX path of s1
set open1 to quoted form of s1
try
	set info1 to "open " & open1
	do shell script info1
end try

(* set pValue to (choose from list ["Manual Removal.rtf", "Change Log.rtf", "General Public Licence.rtf"] with prompt "Choose the file you wish to view." with title "View Information File") as string
if pValue is equal to ["Manual Removal.rtf"] then
	set p23 to "Manual Removal.rtf"
end if
if pValue is equal to ["Change Log"] then
	set p23 to "Change Log.rtf"
end if
if pValue is equal to ["General Public Licence"] then
	set p23 to "GPL"
end if
set upD to POSIX path of ((path to me) & "Information:" & pValue)
set upDR to quoted form of upD as string
set s3 to do shell script "open " & upDR
end *)