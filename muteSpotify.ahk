#singleInstance force

ban:=false
method:=3  ;method 1: check a list from a file   2: check when title doesn't have the format "artist - title"   3:both
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
			ttip( "select the spotify window and click Shift+F1 to use that window as target, the click ok to continue")
		}
	}
	WinWaitClose,%Title%
	loop,2 {
		WinGetTitle,dTitle ,ahk_id %wnd%            
		msg="sp" . %Title%
		;ttip ( msg )
		if (dTitle=="")
		{
			wnd:=0
			Title:=-
		}
		else
		{
			Title:=dTitle
			check()
			;tooltip 'ok'
		}
		sleep,2000 ;recheck after 2 second
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
return
ttip(msg)
{
	tooltip, %msg%
	SetTimer, ctip, 4000
	return
}
ctip:
{
	tooltip,
	return
}

check(){
	global ban
	global wnd
	global Title
	global method
	WinGet, ActivePid, PID, ahk_id %wnd%
	;WinGetTitle,Title, ahk_id %wnd%            
	unmute:=true
	

	if(unmute)
	if( method=2 or method=3){
		if Not InStr(Title," - ")
		{
			unmute:=false
			;fix when the title is not detected, usually happens whe clicking some related artist, the music play without updating the window title
			send,{Media_Play_Pause}
			send,{Media_Play_Pause}
		}
	}
	
	if(unmute)
	if(method=1 or method=3)
	{
		Loop Read, block.lst
		{
			If InStr(A_LoopReadLine,Title) 
			{
				unmute:=false
				;ya esta guardado este elemento
				ban:=false
				break
			}
		}
	}

	if(ban)
	{
		FileAppend %Title%`n,block.lst
		ttip( "Blockeando "Title )
		ban:=false
		unmute:=false
	}

	if (unmute){
		only_unmute(ActivePid)
		;ttip("continue! "Title)
	}
	else
	{
		;ttip( "blocked!!! "Title)
		only_mute(ActivePid)
	}
	return
}
#include mute.ahk
#IfWinExist  ahk_exe Spotify.exe
;add current title to banned list
+F3::
	
	ban:=true
	check()
return
;recheck current song
+F2::
	check()
return
; select the window who we will be monitoring
^+F1::
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

