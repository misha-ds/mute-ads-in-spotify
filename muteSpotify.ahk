#singleInstance force
ban:=""
method:=2  ;method 1: check a list from a file   2: check when title doesn't have the format "artist - title"
SetTitleMatchMode,3                 
WinGetTitle,Title,AHK_class SpotifyMainWindow
Loop                                
{                                   
	WinWaitClose,%Title%
	WinGetTitle,Title ,AHK_class SpotifyMainWindow            
	check()
}                                   
return
check(){
	global ban
	WinGet, ActivePid, PID, ahk_class SpotifyMainWindow
	WinGetTitle,Title, AHK_class SpotifyMainWindow            
	unmute:=true

	if(StrLen(ban)>1)
		append:=true
	else
		append:=false
	if(method=1)
	{
	Loop Read, block.lst
	{
		If InStr(A_LoopReadLine,Title) 
		{
			only_mute(ActivePid)
			unmute:=false
			;msgbox "block!"
			if( not append)
				break
		}
		If append && InStr(A_LoopReadLine, ban)
		{
			append:=false	
		}
	}
	}
	else{
		if Not InStr(Title," - ")
		{
			only_mute(ActivePid)
			unmute:=false
			;msgbox "blocked!!! " %Title%
		}
		else
		{
			;msgbox "continue " %Title%
		}
	}
	if (unmute){
		only_unmute(ActivePid)
		;msgbox "continue! " %Title%
	}
	if(append){
		FileAppend %ban%`n,block.lst
		ban:=
		only_mute(ActivePid)
	}
	;msgbox "checked!"
}
#include mute.ahk
#IfWinExist  ahk_class SpotifyMainWindow
;add current title to banned list
F1::
	WinGetTitle,ban,AHK_class SpotifyMainWindow
	check()
return
;recheck current song
F2::
	check()
return
#If

