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

^r:: ; 줄바꾸기 삭제 
{
Send, ^c
Sleep 50
Clipboard := StrReplace(Clipboard, "`r`n", A_Space)
Sleep 50
run,https://translate.google.com/#view=home&op=translate&sl=en&tl=ko&text=%Clipboard%
}
Return


