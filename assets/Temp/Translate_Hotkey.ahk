#d:: ; 사전 검색 핫키 win + alt + d

Clipboard= ; 클립보드 비우기
Send, ^c ; 현재 단어 복사하기
ClipWait, 1 ; 복사 될 때까지 1초 기다리기

IfEqual, ErrorLevel, 0 ; 제대로 복사 되면 크롬 브라우저로 네이버에 검색
{
    ;DD = http://dic.search.naver.com/search.naver?where=ldic&sm=tab_jum&ie=utf8&query=%Clipboard% ; 네이버 검색 주소
    DD = https://en.dict.naver.com/#/search?query="%Clipboard%"&range=all
    ;DD = https://www.google.com/search?q="%Clipboard%"  ; 구글 검색
    ;DD = https://dic.daum.net/search.do?q="%Clipboard%"   ; 다음 검색
    Run, "chrome.exe" %DD% ; 크롬 으로 실행
}
Return

F4:: ; 줄바꾸기 삭제 
{
Send, ^c
Sleep 50

Clipboard := StrReplace(Clipboard, "`r`n", A_Space)
Clipboard := StrReplace(Clipboard, "-", A_Space)
Clipboard := StrReplace(Clipboard, "&", UriEncode("&"))
run,microsoft-edge:https://translate.google.com/?sl=en&tl=ko&text=%Clipboard%&op=translate
;run,microsoft-edge:https://translate.google.com/#view=home&op=translate&sl=en&tl=ko&text=%Clipboard%&op=translate

}
Return

UriEncode(Uri, Enc = "UTF-8")
{
StrPutVar(Uri, Var, Enc)
f := A_FormatInteger
SetFormat, IntegerFast, H
Loop
{
Code := NumGet(Var, A_Index - 1, "UChar")
If (!Code)
Break
If (Code >= 0x30 && Code <= 0x39 ; 0-9
|| Code >= 0x41 && Code <= 0x5A ; A-Z
|| Code >= 0x61 && Code <= 0x7A) ; a-z
Res .= Chr(Code)
Else
Res .= "%" . SubStr(Code + 0x100, -1)
}
SetFormat, IntegerFast, %f%
Return, Res
}

StrPutVar(Str, ByRef Var, Enc = "")
{
Len := StrPut(Str, Enc) * (Enc = "UTF-16" || Enc = "CP1200" ? 2 : 1)
VarSetCapacity(Var, Len, 0)
Return, StrPut(Str, &Var, Enc)
}