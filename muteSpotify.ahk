#singleInstance force

ban:=""
method:=2  ;method 1: check a list from a file   2: check when title doesn't have the format "artist - title"
SetTitleMatchMode,3                 
DetectHiddenText, On
wnd:=0
Title:=""




WinGetTitle,Title,ahk_id %wnd%
Loop                                
{                                   
	if(wnd==0){
		identify()
		if(wnd==0){
			msgbox select the spotify window and click Shift+F1 to use that window as target, the click ok to continue
		}
	}
	WinWaitClose,%Title%
	WinGetTitle,dTitle ,ahk_id %wnd%            
	if (dTitle=="")
	{
		wnd:=0
		;tooltip 'vacio ['%dTitle%']'
	}
	else
	{
		title:=dTitle
		check()
		;tooltip 'ok'
		}
}                                   
return
identify(){

global wnd
WinGet,id,list,ahk_class  Chrome_WidgetWin_0
Loop, %id%
{
    this_id := id%A_Index%
    WinGetClass, this_class, ahk_id %this_id%
    WinGetTitle, this_title, ahk_id %this_id%
    if( not this_title == ""){ ;// =="Spotify"
        WinActivate, ahk_id %this_id%
	wnd:=this_id
        ;MsgBox, 4, , %this_id% Visiting All Windows`n%a_index% of %id%`nahk_id %this_id%`nahk_class %this_class%`n%this_title%`n`nContinue?
    }
}
}
check(){
	global ban
	global wnd
	WinGet, ActivePid, PID, ahk_id %wnd%
	WinGetTitle,Title, ahk_id %wnd%            
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
#IfWinExist  ahk_exe Spotify.exe
;add current title to banned list
+F3::
	WinGetTitle,ban,ahk_id %wnd%
	check()
return
;recheck current song
+F2::
	check()
return
; select the window who we will be monitoring
+F1::
WinGet, wnd, ID, A
WinGetTitle, t, ahk_id %wnd%
msgbox Selected!  title: %t%    id: %wnd%
return
#If
/*
+F3::
	winget, t1, id, ahk_exe Spotify.exe
	winget, t2, id, ahk_class Chrome_WidgetWin_0
	winget, t3, id, A

msgbox %t1% | %t2% | %t3%
return

+F1::
	


WinGetTitle, t1, ahk_id %wnd%
WinGetTitle, t2, ahk_exe Spotify.exe
WinGetTitle, t3, ahk_class Chrome_WidgetWin_0
msgbox %t1% | %t2% | %t3%

return
*/
