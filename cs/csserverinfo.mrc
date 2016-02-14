;이 스크립트는 절대로 퍼가서는 안되며 퍼가봣자 재가 서버닫으면 소용없는 스크립트입니다.
; 제작자는 uFo 클랜의 AmiE 입니다.

alias server_list { sockclose serverlist | sockopen serverlist clanufo.dothome.co.kr 80 } 

on *:sockopen:serverlist: { 
  write -c cs\serverlist.txt
  if ($sockerr) { echo -a 10Socket_Open3▶ 4접속에러입니다. | return } 
  sockwrite -n $sockname GET /lgsl/index.php HTTP/1.1 
  sockwrite -n $sockname Host: clanufo.dothome.co.kr 
  sockwrite -n $sockname Connection: close 
  sockwrite -n $sockname $crlf 
} 

on *:sockread:serverlist: { 
  if ($sockerr) { echo -a 10Socket_Read3▶ 4접속에러입니다. | return } 
  sockread %temp
  if (!$sockbr) { return } 
  if (!%temp) { %temp = - } 
  if (http://clanufo.dothome.co.kr/lgsl/lgsl_files/../ isin %temp)  { 
    %temp = $remove(%temp,' style='text-decoration:none'>,<a href=')
    writeini cs\csserver.ini server %info_serverip $remove(%temp,http://clanufo.dothome.co.kr)
  }
  if (<a href='qtracker:// isin %temp) {
    %temp = $remove(%temp,<a href='qtracker://,?game=HalfLife&amp;action=show' style='text-decoration:none'>,?game=HalfLife&amp;action=show,qtracker://) 
    set %info_serverip $remove(%temp,$chr(23))
    writeini cs\csserver.ini server %info_serverip %temp
    var %csss $read(cs\serverlist.txt,1)
    write -c cs\serverlist.txt
    write cs\serverlist.txt $remove(%temp,http://clanufo.dothome.co.kr) %csss
  }
  Socket_Close $sockname
  halt
}

alias startssearch {
  if ( %checking == 체킹 ) {
    unset %checking
    /serverwait %info_ip
    .echo -a 14서버리스트 받아오기 성공.
  }
  if ( %checking.domain == 체킹 ) {
    unset %checking.domain
    /serverwait_domain %info_domain_ip
    .echo -a 14서버리스트 받아오기 성공.
  }
}

alias -l Socket_Close { 
  if (</HTML> isin %temp) { sockclose $$1 | unset %temp | unset %info_serverip | if ($$1 == serverlist) { startssearch } | halt } 
} 

echo -a $Socket_Filter(%temp) 

alias -l Socket_Filter { 
  var %x, %i = $regsub($1-,/(^[^<]*>|<[^>]*>|<[^>]*$)/g,$null,%x), %x = $remove(%x,&nbsp;) 
  return %x 
} 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;서버 정보 받기;;;;;;;;;;;;;;;;;;;;;;;;;;;

alias hlinfo {
  set %info_per_ip $1
  if (!$2) tokenize 58 $1
  var %sock = $+(hlinfo-,$ticks)
  ; construct the query to send to the server
  bset &t 1 255 255 255 255
  bset -t &t 5 TSource Engine Query
  bset &t 25 0
  ; actually open the socket, and send the query
  sockudp -k %sock $1-2 &t
  ; closing the socket after 60seconds if there is no response (else it will be closed by another event (see below))
  .timer $+ %sock 1 60 sockclose %sock
}

; this event will get all data sent back from the server
on *:UDPREAD:hlinfo-*:{
  ; save it in a binary variable
  sockread -f &reply

  ; set some local variables that we will use below
  var %offset, %name, %map, %game, %num, %max, %ip, %dir

  if ($chr($bvar(&reply,5)) == m) {
    ; Half-Life 1 info reply
    %offset = 6

    ; save the ip
    %ip = $bvar(&reply,%offset,128).text
    inc %offset $calc($len($bvar(&reply,%offset,128).text) + 1)

    ; the same
    %name = $bvar(&reply,%offset,128).text
    inc %offset $calc($len($bvar(&reply,%offset,128).text) + 1)

    ; the current map
    %map = $bvar(&reply,%offset,128).text
    inc %offset $calc($len($bvar(&reply,%offset,128).text) + 1)

    ; the game directory
    %dir = $bvar(&reply,%offset,128).text
    inc %offset $calc($len($bvar(&reply,%offset,128).text) + 1)

    ; the name of the game
    %game = $bvar(&reply,%offset,128).text
    inc %offset $calc($len($bvar(&reply,%offset,128).text) + 1)

    ; current and maximum players
    %num = $bvar(&reply,%offset)
    %max = $bvar(&reply,$calc(%offset + 1))
  }
  else {

    ; we do the same as above
    %offset = 7

    %name = $bvar(&reply,%offset,128).text
    inc %offset $calc($len($bvar(&reply,%offset,128).text) + 1)

    %map = $bvar(&reply,%offset,128).text
    inc %offset $calc($len($bvar(&reply,%offset,128).text) + 1)

    %dir = $bvar(&reply,%offset,128).text
    inc %offset $calc($len($bvar(&reply,%offset,128).text) + 1)

    %game = $bvar(&reply,%offset,128).text
    inc %offset $calc($len($bvar(&reply,%offset,128).text) + 1)

    %num = $bvar(&reply,$calc(%offset + 2))
    %max = $bvar(&reply,$calc(%offset + 3))
  }


  set %info_name $dll(utf8.dll,convertlocal,%name)
  set %info_map %map
  set %info_num %num $+ / $+ %max
  hlplay %info_per_ip

  ; and turn off the timer closing the socket
  .timer $+ $sockname off
  ; as we can close it now manually
  sockclose $sockname
}
alias hlchal {
  var %sock = $+(hlchal-,$ticks)
  bset &t 1 255 255 255 255 85 255 255 255 255
  sockudp -k %sock $1-2 &t
  sockmark %sock $3- $1-2
  .timer $+ %sock 1 60 sockclose %sock
}
on *:UDPREAD:hlchal-*:{
  sockread -f &reply
  $sock($sockname).mark $bvar(&reply,6,4)
  .timer $+ $sockname off
  sockclose $sockname
}
alias hlplay {
  if (!$2) tokenize 58 $1
  hlchal $1-2 hlplay_query
}
alias hlplay_query {
  ; set a binary variable
  bset &query 1 255 255 255 255 85 $3-
  ; use dynamic socket names again
  var %sock = $+(hlplay-,$ticks)
  ; open the socket
  sockudp -k %sock $1-2 &query
  ; and turn on the timer closing the socket after 60seconds
  .timer $+ %sock 1 60 sockclose %sock
}

; this event will receive all data from the server as response to our query
on *:UDPREAD:hlplay-*:{
  ; we save it in &reply
  sockread -f &reply
  var %i = 1, %num = $bvar(&reply,6), %offset = 7
  var %count = 0, %name, %kills

  ; now we can loop through all player and save some details about them
  while (%i <= %num) {
    inc %offset

    ; the name
    %name = $bvar(&reply,%offset,128).text
    inc %offset $calc($len($bvar(&reply,%offset,128).text) + 1)

    ; the kills
    %kills = $bvar(&reply,%offset).long
    if ($isbit(%kills,32)) dec %kills $calc(2^32)
    inc %offset 8

    ; and if there was a player
    if (%name != $null) {
      ; increase the variable that shows us the number of the player
      inc %count
      ; and echo it to the active window with the kills saved above
      write -i cs\playerlist.txt $dll(utf8.dll,convertlocal,%name) - %kills
    }
    inc %i
  }

  ; if there are no players online, echo it aswell
  if (%count == 0) write cs\playerlist.txt 서버에 플레이어가 없습니다!

  ; turn off the timer
  .timer $+ $sockname off
  server_info
  .echo -a 14서버 정보 받아오기 성공.
  sockclose $sockname
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;서버 콘솔받기;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
alias server_info { sockclose serverinfo | sockopen serverinfo clanufo.dothome.co.kr 80 } 

on *:sockopen:serverinfo: { 
  if ($sockerr) { echo -a 10Socket_Open3▶ 4접속에러입니다. | return } 
  sockwrite -n $sockname GET $readini(cs\csserver.ini,server,%info_realip) HTTP/1.1
  sockwrite -n $sockname Host: clanufo.dothome.co.kr 
  sockwrite -n $sockname Connection: close
  sockwrite -n $sockname $crlf
  %info_console.gettok = 1
  var %i 
  %i = 1
} 

on *:sockread:serverinfo: { 
  if ($sockerr) { echo -a 10Socket_Read3▶ 4접속에러입니다. | return } 
  sockread %temp 
  if (!$sockbr) { return } 
  if (!%temp) { %temp = - }
  ;서버 콘솔값 받아오기
  if ( <td style='background-color:#e4eaf2'> isin %temp || <td style='background-color:#f4f7fa'> isin %temp) { 
    %temp = $remove(%temp,<td style='background-color:#e4eaf2'>,</td>,<td style='background-color:#f4f7fa'>) 
    if ( %info_console.gettok == 1 ) {
      set %info_console.name %temp
      %info_console.gettok = 0
      inc %i
    }
    else {
      set %info_console.value %temp
      %info_console.gettok = 1
    }
    writeini cs\console.ini console %i %info_console.name " $+ %info_console.value $+ " 
    if ( $readini cs\console.ini,console,1 == $null) {
      writeini cs\console.ini console 1 "서버에 너무 많은 신호를 보냈습니다. 잠시후에 다시 시도하세요" 
    }
    Socket_Close $sockname
    halt
  }
}
on *:sockclose:serverinfo: {
  /dialog -m cssi cssi
  msg $active 14"4 $+ %info_name $+ 14" 의 정보를 표시합니다. $logo
}

;;;;;;;;;;;;;;;;;;;;;;;;;;도메인 아이피 콘버트하기;;;;;;;;;;;;;;;;;;;;;;;;;;;

alias domain_convert { set %domain $1 | domain_server } 
alias domain_server { sockclose domainconvert | sockopen domainconvert domaintoip.com 80 }

on *:sockopen:domainconvert: { 
  if ($sockerr) { echo -a 10Socket_Open3▶ 4접속에러입니다. | return } 
  sockwrite -n $sockname GET /ip.php?domain= $+ %domain HTTP/1.1
  sockwrite -n $sockname Host: domaintoip.com
  sockwrite -n $sockname Connection: close 
  sockwrite -n $sockname $crlf 
} 

on *:sockread:domainconvert: { 
  if ($sockerr) { echo -a 10Socket_Read3▶ 4접속에러입니다. | return } 
  sockread %temp 
  if (!$sockbr) { return } 
  if (!%temp) { %temp = - } 
  if (IP Address for domain isin %temp) {
    if ( %domainway == 1 ) {
      msg $active $backs2($remove(%temp,rel="nofollow" target="_self" title=",%domain, IP Address for Domain ,"><h2 class="h2",<table border="0" cellspacing="2" cellpadding="2" align="center"><tr><td width="120"><a href=")class="h2"))
      unset %domainway
    }
    else {
      set %info_ip $backs2($remove(%temp,rel="nofollow" target="_self" title=",%domain, IP Address for Domain ,"><h2 class="h2",<table border="0" cellspacing="2" cellpadding="2" align="center"><tr><td width="120"><a href=")class="h2"))
      hlinfo %info_ip $+ $chr(58) $+ %info_port
    }
    unset %domain
    Socket_Close $sockname
  } 
}
;;;;;;;;;;;;;;;;;;;;;;;;;다이얼로그;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dialog cssi {
  title "Counter Strike Server Information By uFo`AmiE"
  size -1 -1 322 186
  option dbu
  text "서버 이름", 1, 132 13 28 9
  edit "", 3, 160 13 105 10, read return autohs center
  text "맵", 5, 132 23 28 8, center
  text "ddos.Hanirc.org #ufo AmiE", 6, 189 170 77 7
  edit "", 7, 160 23 105 10, read center
  button "닫기", 8, 277 169 37 12, cancel
  text "인원수", 9, 132 33 28 8, center
  edit "", 10, 160 33 105 10, read center
  box "플레이어 - 킬수", 11, 130 54 160 107
  list 12, 4 19 124 150, sort size hsbar vsbar
  list 2, 134 61 146 94, sort size
  text "콘솔", 4, 52 8 25 8, center
  check "기본 콘솔 보기", 13, 6 170 56 10
  check "sXe콘솔 보기", 14, 72 170 48 10
  icon 15, 268 6 44 44
}
on *:dialog:cssi:init:0 {
  var %i = 1
  /did -i cssi 3 1 %info_name
  /did -i cssi 7 1 %info_map
  /did -i cssi 10 1 %info_num
  :trys
  if ( $read(cs\playerlist.txt,%i) != $null ) {
    /did -i cssi 2 1 $read(cs\playerlist.txt,%i)
  }
  inc %i
  if ( %i <= 32 ) { goto trys }

  %i = 1
  :trydefault
  if ( $readini(cs\console.ini,console,%i) != $null ) {
    /did -i cssi 12 1 $readini(cs\console.ini,console,%i)
  }
  inc %i
  if ( %i <= 150 ) { goto trydefault }
  /did -g cssi 15 $remove(image\map\ %info_map $+ .jpg,$chr(32))
}

on *:dialog:cssi:sclick:13,14 {
  if ( $did(cssi,13).state == 1 && $did(cssi,14).state == 0 ) {
    /did -r cssi 12
    %i = 1
    :try10
    if ( $readini(cs\console.ini,console,%i) != $null && allow isin $readini(cs\console.ini,console,%i) || mp isin $readini(cs\console.ini,console,%i) || sv isin $readini(cs\console.ini,console,%i)) {
      /did -i cssi 12 1 $readini(cs\console.ini,console,%i)
    }
    inc %i
    if ( %i <= 150 ) { goto try10 }
  }
  if ( $did(cssi,13).state == 1 && $did(cssi,14).state == 1 ) {
    /did -r cssi 12
    %i = 1
    :try11
    if ( $readini(cs\console.ini,console,%i) != $null && allow isin $readini(cs\console.ini,console,%i) || sxe isin $readini(cs\console.ini,console,%i) || mp isin $readini(cs\console.ini,console,%i) || sv isin $readini(cs\console.ini,console,%i)) {
      /did -i cssi 12 1 $readini(cs\console.ini,console,%i)
    }
    inc %i
    if ( %i <= 150 ) { goto try11 }
  }
  if ( $did(cssi,13).state == 0 && $did(cssi,14).state == 0 ) {
    /did -r cssi 12
    %i = 1
    :try00
    if ( $readini(cs\console.ini,console,%i) != $null ) {
      /did -i cssi 12 %i $readini(cs\console.ini,console,%i)
    }
    inc %i
    if ( %i <= 150 ) { goto try00 }
  }
  if ( $did(cssi,13).state == 0 && $did(cssi,14).state == 1 ) {
    /did -r cssi 12
    %i = 1
    :try01
    if ( $readini(cs\console.ini,console,%i) != $null && sxe isin $readini(cs\console.ini,console,%i)) {
      /did -i cssi 12 %i $readini(cs\console.ini,console,%i)
    }
    inc %i
    if ( %i <= 150 ) { goto try01 }
  }
}

on *:dialog:cssi:close:0 {
  unset %info_*
  unset %i
  unset %temp
  unset %tmp
  .remove cs\console.ini
  .remove cs\playerlist.txt
  .remove cs\serverlist.txt
  .remove cs\csserver.ini
}
