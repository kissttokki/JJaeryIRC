alias -l GetLibrary { return SpeedCheck.dll }
;; ip nick
#trace off
raw 352:*: { 
  inc %trace.counter
  if (%trace.counter > 3) { msg $active %logo 검색된 결과가 3개 이상입니다. 좀더 범위를 압축하여 검색해주세요. | unset %trace | .disable #trace }
  else { msg $active %logo 0,4닉4네임[ $6 ] 0,3아3이피[ $4 ] 0,12채12널[ $2 ] 0,14사14용자명[ $3 ] }
  halt
}
raw 315:*: { .disable #trace  | halt }
#trace end

#trace2 off
raw 352:*: { 
  echo $active %logo 0,4닉4네임[ $6 ] 0,3아3이피[ $4 ] 0,12채12널[ $2 ] 0,14사14용자명[ $3 ]
  halt
}
raw 315:*: { .disable #trace2  | halt }
#trace2 end

raw 205:*: { 
  msg $active %logo $4
  halt 
}
;; 챈섭
alias Chanserv_info { 
  sockclose Chanserv_info
  sockopen Chanserv_info pink.the-7.net 80 
}

;;--sock입력part--;;

On 1:sockopen:Chanserv_info:sockwrite -nt Chanserv_info GET http://hanirc-chanstat.the-7.net/csqual.cgi?channel= $+ %Chanserv_chan 

;;--Web_temp 추출part--;;

On *:sockread:Chanserv_info: { 
  sockread %Chanserv_temp
  if ( 존재하지 isin %Chanserv_temp ) {
    set %Chanserv_error $chr(91) 4- Error - $chr(93) $chr(35) $+ %Chanserv_chan 채널에 대한 정보가 존재하지 않습니다.
    halt
  }
  else if ( 비율</TD><TD> isin %Chanserv_temp ) {
    set %Chanserv_msg1 7인원 10명 넘는 비율 ▷ $remove(%Chanserv_temp,<TR><TD>10명 넘는 비율</TD><TD>,</TD></TR>) 
    halt
  }
  else if ( 인원</TD><TD> isin %Chanserv_temp ) {
    set %Chanserv_msg2 7평균 인원 ▷ $remove(%Chanserv_temp,<TR><TD>평균 인원</TD><TD>,</TD></TR>)
    halt
  }
  else if ( 점수</TD><TD> isin %Chanserv_temp ) { 
    set %Chanserv_msg3 7사용도 점수 ▷ $remove(%Chanserv_temp,<TR><TD>사용도 점수</TD><TD>,</TD></TR>)
    halt
  }
  else if ( 자격</TD><TD> isin %Chanserv_temp ) { 
    if ( 회수됩니다.</font></TABLE></TD></TR> isin %Chanserv_temp ) {
      set %Chanserv_msg4 7챈섭 신청 자격 ▷ 신청 할 수 없습니다.Chanserv 가 있더라도 회수됩니다.
      halt
    }
    else if ( 신청하시기 isin %Chanserv_temp ) {
      set %Chanserv_msg4 7챈섭 신청 자격 ▷ 신청 할 수 있습니다.약관을 한번 더 확인하시고 신청하시기 바랍니다.
      halt
    }
    else if ( 공백 시간 isin %Chanserv_temp ) {
      set %Chanserv_msg4 7챈섭 신청 자격 ▷ 신청 할 수 없습니다. 채널 공백시간 초과입니다.
    }
    else if ( 사용도 점수 isin %Chanserv_temp ) {
      set %Chanserv_msg4 7챈섭 신청 자격 ▷ 신청 할 수 없습니다. 사용도 점수 미달입니다.
    }
  }
} 

;;--sock출력part--;;

on *:sockclose:Chanserv_info: {
  if ( %Chanserv_error != $null ) {
    msg %chanservinfo_chan 10 $+ $chr(35) $+  %Chanserv_chan 채널 Chanserv 신청자격 Info... 
    msg %chanservinfo_chan %Chanserv_error
    msg %chanservinfo_chan --- Copyright(C) HanIRC Operator Group, 2004. --- 
    unset %Chanserv_*
    halt
  }
  else if ( %Chanserv_error == $null ) {
    msg %chanservinfo_chan 10 $+ $chr(35) $+ %Chanserv_chan 채널 Chanserv 신청자격 Info...
    msg %chanservinfo_chan %Chanserv_msg1
    msg %chanservinfo_chan %Chanserv_msg2
    msg %chanservinfo_chan %Chanserv_msg3
    msg %chanservinfo_chan %Chanserv_msg4
    msg %chanservinfo_chan --- Copyright(C) HanIRC Operator Group, 2004. --- 
    unset %Chanserv_*
    halt
  }
}

;; input

on 1:INPUT:*: {
  if ( $1 == !채널 ) {
    /say $1
    /say 옵 2 $opnick(#,0) 명 디옵 : 4 $nopnick(#,0) 명 보이스 : 6 $vnick(#,0) 명 디보이스 : 10 $nvnick(#,0) 명 총 12 $nick(#,0,a) 명 입니다.
    halt
  }
  if ($1- == !아피) {
    /ip
  halt }
  if ($1- == !입실수) {
    /say $1
    /say 15[14 $+ $me $+ 15]12 님께서 입실한 채널의 수는 15[14 $+ $chan(0) $+ 15]12 개 입니다.  $logo
  halt }

  if (($1 == !정보) && ($2-)) {
    /say !정보 $2-
    /whois $2-
  halt } 

  if ($1 == !소스) {
    if (%steamdir == $null) {
      /say $1-
      /say 스팀의 경로가 설정되지 않았습니다. '!설정'을 하셔서 스팀의 경로를 설정해주시기 바랍니다. 
      halt
    }
    else {
      /say $1-
      /say 12 $me 1 is 3 $2-  1connecting...
      /run %SteamDIR -applaunch 240 -console %노포스 +connect $remove$+ $2-
    halt }
  }
  if ($1 == !하프) {
    if (%steamdir == $null) {
      /say $1-
      /say 스팀의 경로가 설정되지 않았습니다. '!설정'을 하셔서 스팀의 경로를 설정해주시기 바랍니다. 
      halt
    }
    else {
      /say $1-
      /say 12 $me 1 is 3 $2-  1connecting...
      /run %SteamDIR -applaunch 70 -console %노포스 +connect $remove$+ $2-
    halt }
  }
  if (($1 == !버전) && ($2-)) {
    /say !버전 $2-
    /version $2-
  halt }
  IF ($1- == !트레이) {
    /say $1
    /amsg 14 창을 트레이상태로 전환합니다. $logo
    /showmirc -t
  halt }
  IF ($1- == !컴터) {
    /say $1
    /SystemInfo
  halt }
  IF ($1- == !음악) {
    /say $1
    /say 14Dialog 7Loading1 ...14 ［ 3Cool Mp3 Player14 ］─━━━━ $logo
    /mp3_p
  halt }
  IF ($1- == !뮤직) {
    /say $1
    /say 14Dialog 7Loading1 ...14 ［ 3Cool Mp3 Player14 ］─━━━━ $logo
    /mp3_p
  halt }
  if ($1 == !스팀) {
    if (%steamdir == $null) {
      /say $1-
      /say 스팀의 경로가 설정되지 않았습니다. '!설정'을 하셔서 스팀의 경로를 설정해주시기 바랍니다. 
      /run http://cdn.steampowered.com/download/SteamInstall.msi
      halt
    }
    elseif (%steamdir != $2-) {
      .say $1-
      .say 14Program 7Loading1 ...14 ［ 3Steam14 ］─━━━━ $logo
      .run %steamdir
      halt
    }   
  }
  if ($1 == !SXE) {
    if (%sxedir == $null) {
      /say $1-
      /say sXe Injected의 경로가 설정되지 않았습니다. '!설정'을 하셔서 sXe의 경로를 설정해주시기 바랍니다. 
      /run http://www.sxe-injected.com/downloads
      halt
    }
    elseif (%sxedir != $2-) {
      .say $1-
      .say 14Program 7Loading ...14 ［ 3sXe Injected14 ］─━━━━ $logo
      .run %sxedir 
      halt
    }
  }
  if ($1 == !hl || $1 == !hltv) {
    if (%hltvdir == $null) {
      /say $1-
      /say HLTV의 경로가 설정되지 않았습니다. '!설정'을 하셔서 HLTV의 경로를 설정해주시기 바랍니다. 
      halt
    }
    elseif (%hltvdir != $2-) {
      .say $1-
      .say 14Program 7Loading ...14 ［ 3HLTV14 ］─━━━━ $logo
      .run -p %hltvdir
      .halt
    }
  }
  if ($1- == !카온) {
    if (%csodir == $null) {
      /say $1-
      /say 카스온라인의 경로가 설정되지 않았습니다. '!설정'을 하셔서 경로를 설정해주시기 바랍니다. 
      halt
    }
    elseif (%csodir != $2-) {
      .say $1-
      .say 14Program 7Loading1 ...14 ［ 3Counter Strike : Online14 ］─━━━━ $logo
      .run -p %csodir
      if ( %ingametray == 1 ) {
        /showmirc -n
      }
      halt
    }   
  }
  IF ($1- == !사이트) {
    /site
  halt } 
  if (($1 == !웹)) {
    if ($2 == $null ) { .say !웹 | /run C:\Program Files\Internet Explorer\iexplore.exe | /halt }
    /say !웹 http:// $+ $remove($2,http://)
    /say 14Web 7Loading ...14 ［3 http:// $+ $remove($2,http://) 14］─━━━━ $logo
    /run http:// $+ $remove($2,http://)
  halt } 
  if (($1 == !웹2)) {
    if ($2 == $null ) { .echo $mini !웹2 뒤에 웹주소를 입력하세요. | /halt }
    /say !웹2 http:// $+ $remove($2,http://)
    /say 14Web 7Loading ...14 ［3 http:// $+ $remove($2,http://) 14］─━━━━ $logo
    /ircweb http:// $+ $remove($2,http://)
  halt }
  IF ($1- == !시간) {
    /times
  halt } 
  IF ($1- == !주사) {
    /jusawe
  halt } 
  IF ($1- == !사용법) {
    /say $1
    /say 14Program 7Loading ...14 ［ 3사용설명서14 ］─━━━━ $logo
    /teamcrazyhelp
  halt }
  if ($1- == !청) {
    /clearall
    /say $1
    /say 14모든 창을 청소합니다. $logo
  halt }
  if ($1- == !닉) {
    /say !닉
    /echo 기본설정을 바꾸시려면 !설정 에서 말머리,말꼬리 설정에서 바꿔주시면 됩니다. (다시 돌아오시려면 !닉 한번더하세요)
    /setting.update saytit saytit
  halt }
  if ($1- == !메) {
    /say !메
    /memo
  halt }    
  if ($1- == !본닉) {
    /say !본닉
    /nick %nickdefault   
  halt }  
  if ($1- == !잠수) {
    /say !잠수
    /nick %nick2nd $+ l잠수
  halt }
  if ($1- == !밥) {
    /say !밥
    /nick %nick2nd $+ l식사중
  halt }
  if ($1- == !시체) {
    /say !시체
    /nick %nick2nd $+ l시체
  halt }
  if ($1- == !휴식) {
    /say !휴식
    /nick %nick2nd $+ l휴식
  halt }
  if ($1- == !잠) {
    /say !잠
    /nick %nick2nd $+ l쿨쿨
  halt }
  if ($1- == !봇) {
    /say !봇
    /nick %nick2nd $+ l봇
  halt }
  if ($1- == !매치) {
    /say !매치
    /nick %nick2nd $+ l매치
  halt }
  if ($1- == !그림판) {
    /say $1
    /run mspaint
    /say 14Program 7Loading ...14 ［ 3그림판14 ］─━━━━ $logo
  halt }
  if ($1- == !메모장) {
    /say $1
    /run notepad
    /say 14Program 7Loading ...14 ［ 3메모장14 ］─━━━━ $logo
  halt }
  if ($1- == !청소) {
    /say !청소
    /clear
  halt }
  if ($1- == !도움말) {
    /say !도움말
    /ufohelp
  halt }   
  if ($1- == !내메모) {
    /say !내메모
    /say $nick 10 메모내용: 14 %memo
  halt }
  if ($1- == !할) {
    /say !할
    /do
  halt }
  if ($1- == !설정) {
    /say !설정
    /config
  halt }
  if ($1- == !종료) {
    /say !종료
    if ( $os == xp || $os == Vista ) {
      ./run shutdown -s -t 00
      /exit
      halt
    }
    else {
      /dll Sd.dll WinMenu
    halt }
  }
  if ($1- == !리붓) {
    /say !리붓
    if ($os == xp || $os == Vista ) {
      ./run shutdown -r -t 00
      /exit
      halt
    }
    else {
      /dll Sd.dll WinMenu
      halt 
    }
  } 
  if ($1- == !토픽) {
    /say !토픽
    /say 14 $chan 토픽☞ $chan($chan).topic
  halt }
  if ($1 == !토픽고) {
    /say $1-
    topicgo $chan($chan).topic 
  halt } 
  if ($1 == !스세고) {
    /say $1-
    /var %토픽서버 $chan($chan).topic 
    /run %sxedir
    /say 14RUN :12 sXe Injected을 실행합니다. $logo  
    /sxego
    /echo 4 25초 14안에 sXe injected 를 최상위로 활성화 시켜주세요.
    .timerantiflood 1 25 .timersxe off
  halt } 
  if ($1 == !노바고) {
    /say $1-
    /var %토픽서버 $chan($chan).topic 
    /say 14Run:12 Novacap14 을 실행합니다..
    topicgo $chan($chan).topic 
    /run $mircdirutil\Novacap\novacap.exe
    /showmirc -n
  halt }
  if ($1 == !hl토픽 || $1 == !hl토픽고) {
    /say $1-
    hltopicgo $chan($chan).topic
  halt } 
  if ($1 == !챈섭)  {
    if ( $2 == $null ) {
      say $1-
      set %chanservinfo_chan $chan
      set %Chanserv_chan $remove($chan,$chr(35))
      sockclose Chanserv_info
      sockopen Chanserv_info hanirc-chanstat.the-7.net 80
      halt
    }
    else if ( $2 != $null ) {
      say $1-
      set %chanservinfo_chan $chan
      set %Chanserv_chan $remove($2,$chr(35))
      sockclose Chanserv_info
      sockopen Chanserv_info hanirc-chanstat.the-7.net 80
      halt
    }
  }
  if ( $1 == !추적 ) {
    if ($2) { unset %trace.counter | .enable #trace | .who $2 }
    else { .say $1- |  msg $active %logo 사용법 : !추적 검색어 1(* 와일드카드 사용가능 ex : !추적 *길동*) | .halt }
  }
  if ( $1 == !@추적 ) { .enable #trace2 | .who $2 }
  if ( $1 == !리얼 ) { .trace $2 }
  if ( $1 == !찾기 ) {
    msg $active $1-
    echo -a $mini 좀더 자세한 정보를 원하시면 5!추적 아이피1 하세요.
    set %ipnickv On
    who $2
    halt
  }
  if ($1 == !체크)  {
    var %Type
    if ( $2 == 다운로드 ) {
      %Type = DN
    }
    else if ( $2 == 업로드 ) {
      %Type = UP
    }
    var %bResult = $dll($GetLibrary,Check,%Type)
    if ( %bResult == S_OK ) {
      var %Speed = $Dll($GetLibrary,GetSpeed,)
      var %temp = $null 
      var %bps = $null
      var %bts = $null
      %temp = $gettok(%Speed,1,$asc(|))
      /say $1-
      if ( %temp != - ) {
        %bps = $gettok(%temp,1,$asc(!))
        %bts = $gettok(%temp,2,$asc(!))
        /say 인터넷 다운로드 속도: %bps ( 4 %bts )
      }
      %temp = $gettok(%Speed,2,$asc(|))
      if ( %temp != - ) {
        %bps = $gettok(%temp,1,$asc(!))
        %bts = $gettok(%temp,2,$asc(!))
        /say 인터넷 업로드 속도: %bps ( 12 %bts )
      }
    }
    else if ( %bResult == S_FAIL ) {
      /echo -a 인터넷 속도측정 오류: $Dll($GetLibrary,GetError,)
    }
    halt
  }
  if ($1 == !검색) {
    .say $1-
    if ( $2 == $null ) {
      .say 14Program 7Loading ...14 ［ 3검색툴바14 ］─━━━━ $logo
      .mirc_tool_start
      halt
    }
    else {
      .say 14Program 7Loading ...14 ［ 3네이버 " $+ $2- $+ " 검색14 ］─━━━━ $logo
      run http://search.naver.com/search.naver?where=3&oldquery=&restrict=0&field=0&host=&dir=&homepage=0&display=10&start=1&query= $+ $2- $+ 
      halt
    }
  }
  if ($1 == !네이버) {
    say $1-
    if ($2 == $null) {
      run http://www.naver.com
      .say 14Program 7Loading ...14 ［ 3www.naver.com14 ］─━━━━ $logo
    }
    else {
      .say 14Program 7Loading ...14 ［ 3네이버 " $+ $2- $+ " 검색14 ］─━━━━ $logo
      run http://search.naver.com/search.naver?where=3&oldquery=&restrict=0&field=0&host=&dir=&homepage=0&display=10&start=1&query= $+ $2- $+
    }
    halt
  }
  if ($1 == !구글) {
    say $1-
    if ($2 == $null) {
      run http://www.google.com
      .say 14Program 7Loading ...14 ［ 3www.google.com14 ］─━━━━ $logo
    }
    else {
      .say 14Program 7Loading ...14 ［ 3구글 " $+ $2- $+ " 검색14 ］─━━━━ $logo
      run "http://www.google.co.kr/search?q= $+ $2- $+ "
    }
    halt
  }
  if ($1 == !다운) {
    .say $1-
    .say 14Dialog 7Loading ...14 ［ 3Downloader14 ］─━━━━ $logo
    downloader_start
    halt
  }
  if ($1 == !인증) {
    .say $1-
    .say 14Reg 7Write1 ...14 ［ 3mIRC 등록인증14 ］─━━━━ $logo
    .run $mircdir인증.reg
    halt
  }
  if ($1 == !재생빈도) {
    .say $1-
    .say 14Reg 7Write1 ...14 ［ 3Geforce 재생빈도14 ］─━━━━ $logo
    coolbit
    halt
  }
  if ($1 == !자동조인) {
    if ($2 == $null) {
      say $1-
      if ($chan($active).key != $null) {
        write auto_join_p.txt /join $chan $chan($active).key
        msg $active $logo 4 $chan 채널을 키워드4 $chan($active).key (으)로 자동조인에 추가했습니다.
      }
      else {
        var %auto_join_chan = $read(auto_join.txt,1)
        write -c auto_join.txt
        write auto_join.txt %auto_join_chan $chan
        write auto_join_list.txt $chan
        msg $active $logo 4 $chan 채널을 자동조인에 추가했습니다.
        echo -a $mini 4비번(키워드)방 자동조인은 옵이 있을 시에만 가능합니다. 
        echo -a $mini 4만약 지금 비번방을 자동조인했다면 !자동조인 삭제를 하신후 옵을 받으시고 !자동조인 하시기 바랍니다.
      }
    }
    if ($2 == 삭제) {
      say $1-
      if ($chan($active).key != $null) {
        write -dw* $+ $active $+ * auto_join_p.txt
        msg $active $logo 4 $chan 채널을 자동조인에서 삭제했습니다.
      }
      else {
        var %auto_join_im = $read(auto_join.txt,1)
        var %auto_join_chan = $remove(%auto_join_im,$active)
        write -c auto_join.txt
        write auto_join.txt %auto_join_chan
        write -dw* $+ $active auto_join_list.txt
        msg $active $logo 4 $chan 채널을 자동조인에서 삭제했습니다.
      }
    }
    if ($2 == 모두삭제) {
      say $1-
      write -c auto_join.txt
      write -c auto_join_p.txt
      write -c auto_join_list.txt
      msg $active $logo 4 모든채널을 자동조인에서 삭제했습니다.
    }
    halt 
  }
  if ($1 == !조인설정) {
    say $1
    say 14Dialog 7Loading ...14 ［ 3자동조인 Controller14 ］─━━━━ $logo
    /dialog -ma Autojoin_Controler Autojoin_Controler
    halt
  }
}
;; !찾기
alias 검색 { who $1 }
alias who {
  if ( $active != Status Window ) {
    unset %ipnick
    who $1
  }
}

raw 315:*: {
  if ( %ipnickv == on ) {
    msg $active 5검색결과: $+ $iif(%ipnick == $null,검색한 사용자가 없습니다.,%ipnick)
    unset %ipnick %ipnickv
  }
  else { 
    echo $color(info) -a *** 검색결과: $+ $iif(%ipnick == $null,검색한 사용자가 없습니다.,%ipnick)
    unset %ipnick %ipnickv
  }
  halt
}

raw 352:*: {
  if ( %ipnickv == on ) {
    if ( $len(%ipnick) <= 400 ) { set %ipnick %ipnick $6 }
    else {
      msg $active 5검색결과: $+ %ipnick
      unset %ipnick
    }
  }
  else {
    if ( $len(%ipnick) <= 400 ) { set %ipnick %ipnick $6 }
    else {
      echo $color(info) -a *** 검색결과: $+ %ipnick
      unset %ipnick
    }
  }
  halt
}

raw 416:*: {
  if ( %ipnickv == on ) {
    msg $active 5데이터가 너무 많습니다.
    unset %ipnick %ipnickv
  }
  else {
    echo $color(info) -a *** 데이터가 너무 많습니다.
    unset %ipnick %ipnickv
  }
  halt
}

;; 토픽 setting

alias st {
  if ($active ischan) {
    dialog $iif($dialog(settopic),-v,-m) settopic settopic
    dialog -t settopic Set $active topic (Manu :D)
    did -ra settopic 5 $chan($active).topic
    if ($me isop $active) || ($me ishop $active) || (t !isincs $gettok($chan($chan).mode,1,32)) { did -e settopic 7 }
    if ($topiclen isnum) { did -ra settopic 4 $calc($topiclen - $len($chan($active).topic)) }
    prevtopic
  }
  else { echo $active 이 스크립은 오직 체널에서만 가능합니다. :D }
}
on *:rawmode:#:{ if (($me isop $chan) || ($me ishop $chan) || (t !isincs $gettok($chan($chan).mode,1,32))) && ($chan == $gettok($dialog(settopic).title,2,32)) { did -e settopic 7 } }
dialog settopic {
  size -1 -1 249 50
  option dbu
  text 최대 토픽 길이:,1,3 3 70 9
  text 남은 토픽 글자 갯수:,2,165 3 70 9
  text $topiclen,3,52 3 15 9,right
  text $topiclen,4,220 3 25 9,right
  edit "",5,2 12 245 11,autohs limit 600
  icon 8,2 23 245 13,topic\ttemp.bmp
  button "취소",6,164 37 40 11,cancel
  button "설정 :D",7,207 37 40 11,ok disabled
}
on *:dialog:settopic:sclick:7:{
  var %c = $gettok($dialog($dname).title,2,32)
  if ($did == 9) && ($did(5) != $chan(%c).topic) { .msg q settopic %c $iif($did(5),$ifmatch,) }
  elseif ($did(5) != $chan(%c).topic) { raw -q topic %c : $+ $did(5) }
  dialog -x $dname
}
on *:dialog:settopic:edit:5:{
  if ($topiclen isnum) { did -ra settopic 4 $calc($topiclen - $len($did(5))) }
  prevtopic
}
alias prevtopic {
  if ($dialog(settopic)) {
    window -ph +d @ttopic 0 0 488 19
    drawfill @ttopic $color(back) $color(back) 0 0
    drawtext -pb @ttopic $color(topic) $color(back) $+(",$window($active).font,") $window($active).fontsize 2 1 $iif($did(settopic,5),$ifmatch,)
    drawsave @ttopic "topic\ttemp.bmp"
    close -@ @ttopic
    did -g settopic 8 "topic\ttemp.bmp"
  }
}
raw 5:*:{ if ($gettok($matchtok($1-,TOPICLEN=,1,32),2,61)) { set %topiclen. $+ $cid $ifmatch } }
alias topiclen { return $iif(%topiclen. [ $+ [ $cid ] ],$ifmatch,unknown) }

;; text on event

ON *:text:*!메모:#:/notice $nick 10메모내용: 14 %memo
on *:text:*!버전:#:/notice $nick $logo

;; 자동조인 컨트롤

dialog Autojoin_Controler {
  title "자동 채널 조인 컨트롤러"
  size -1 -1 132 147
  option dbu
  list 10, 10 15 64 113, size vsbar
  box "채널 리스트", 1, 4 6 76 128
  button "채널 추가", 20, 91 21 33 11
  button "채널 삭제", 30, 91 34 33 11
  button "채널 조인", 40, 91 47 33 11
  button "모두 삭제", 50, 91 60 33 11
  text "채널 정보", 3, 89 75 29 8
  text "     메 뉴", 2, 91 11 32 8
  text "총인원 :", 4, 85 86 25 8
  text "   ∞", 60, 108 86 19 8
  text "방장수 :", 5, 85 95 25 8
  text "   ∞", 70, 108 95 19 8
  text "   ∞", 80, 108 104 19 8
  text "보이스 :", 6, 85 104 25 8
  text "일반인 :", 7, 85 113 25 8
  text "   ∞", 90, 108 113 19 8
  button "취소", 3000, 0 0 0 0, cancel
}
on *:dialog:Autojoin_Controler:init:*:{ 
  did -r Autojoin_Controler 10
  var %i 1
  while (%i <= 100) {
    if ($dialog(Autojoin_Controler)) {
      if ($null != $read(Auto_join_list.txt,%i)) { /did -a Autojoin_Controler 10 $read(auto_join_list.txt,%i) }
    }
    inc %i
  }
}
dialog 경고MSG {
  title "경고!"
  size -1 -1 99 42
  option dbu
  text "이 명령을 수행하게 되면, 자동조인이 설정된 모든 채널이 삭제됩니다. 그래도 계속 하시겠습니까?", 1, 5 5 90 18
  button "네", 2, 4 26 43 12, ok
  button "아니오", 3, 52 26 43 12, cancel
}

on *:dialog:Autojoin_Controler:sclick:10:{ 
  did -ra Autojoin_Controler 60 　 $+ $nick($did(Autojoin_Controler,10).seltext,0)
  did -ra Autojoin_Controler 70 　 $+ $opnick($did(Autojoin_Controler,10).seltext,0)
  did -ra Autojoin_Controler 80 　 $+ $vnick($did(Autojoin_Controler,10).seltext,0)
  did -ra Autojoin_Controler 90 　 $+ $nopnick($did(Autojoin_Controler,10).seltext,0)
}
on *:dialog:Autojoin_Controler:sclick:20:{
  var %auto_join_chan = $read(auto_join.txt,1)
  /set %추가채널 $$?="추가할 채널명은? (앞에 #까지 써주세요 키워드가 있는방은 채널안에서 !자동조인 이라 외치시면 됩니다.)"
  write -c auto_join.txt
  write auto_join.txt %auto_join_chan %추가채널 
  write auto_join_list.txt %추가채널
  /did -a Autojoin_Controler 10 %추가채널
  /unset %추가채널
} 

on *:dialog:Autojoin_Controler:sclick:30:{
  if ($did(Autojoin_Controler,10).seltext == $null) { echo -a $mini 4 $+ 삭제할 채널을 목록에서 선택해 주세요. }
  else if ($did(Autojoin_Controler,10).seltext != $null) {
    var %auto_join_im = $read(auto_join.txt,1)
    var %auto_join_chan = $remove(%auto_join_im,$did(Autojoin_Controler,10).seltext)
    write -c auto_join.txt
    write auto_join.txt %auto_join_chan
    write -dw* $+ $did(Autojoin_Controler,10).seltext auto_join_list.txt
    did -d Autojoin_Controler 10 $did(Autojoin_Controler,10,1).sel
  }
} 
on *:dialog:Autojoin_Controler:sclick:40:{
  /join $did(Autojoin_Controler,10).seltext
} 
on *:dialog:Autojoin_Controler:sclick:50:{
  /dialog -ma 경고MSG 경고MSG
} 
on *:dialog:경고MSG:sclick:2:{
  /write -c auto_join.txt 
  /write -c auto_join_list.txt
  /did -r Autojoin_Controler 10
}
on *:dialog:경고MSG:sclick:3:{
  halt
}

;; 오토 채널 설정

on *:join:#: {
  if ( $nick == $me ) && ( $readini(autoset.ini,$chan,Joinme) == On ) && ( $readini(autoset.ini,$chan,Auto) == On ) { .msg $chan $readini(autoset.ini,$chan,Joinmem) }
  else if ( $nick == $me ) && ( $readini(autoset.ini,Setting,Joinme) == On ) && ( $readini(autoset.ini,$chan,Auto) != On ) { .msg $chan $readini(autoset.ini,Setting,Joinmem) }
  else if ( $nick != $me ) && ( $readini(autoset.ini,$chan,Join) == On ) && ( $readini(autoset.ini,$chan,Auto) == On ) { .notice $nick $readini(autoset.ini,$chan,Joinm) }
  else if ( $nick != $me ) && ( $readini(autoset.ini,Setting,Join) == On ) && ( $readini(autoset.ini,$chan,Auto) != On ) { .notice $nick $readini(autoset.ini,Setting,Joinm) }

  if ( $nick != $me ) && ( $me isop $chan ) && ( $readini(autoset.ini,$chan,Autoop) == On ) && ( $readini(autoset.ini,$chan,Autovo) == On ) && ( $readini(autoset.ini,$chan,Auto) == On ) { .mode $chan +vo $nick $nick }
  else if ( $nick != $me ) && ( $me isop $chan ) && ( $readini(autoset.ini,Setting,Autoop) == On ) && ( $readini(autoset.ini,Setting,Autovo) == On ) && ( $readini(autoset.ini,$chan,Auto) != On ) { .mode $chan +vo $nick $nick }
  else if ( $nick != $me ) && ( $me isop $chan ) && ( $readini(autoset.ini,$chan,Autoop) == On ) && ( $readini(autoset.ini,$chan,Auto) == On ) { .mode $chan +o $nick }
  else if ( $nick != $me ) && ( $me isop $chan ) && ( $readini(autoset.ini,Setting,Autoop) == On ) && ( $readini(autoset.ini,$chan,Auto) != On ) { .mode $chan +o $nick }
  else if ( $nick != $me ) && ( $me isop $chan ) && ( $readini(autoset.ini,$chan,Autovo) == On ) && ( $readini(autoset.ini,$chan,Auto) == On ) { .mode $chan +v $nick }
  else if ( $nick != $me ) && ( $me isop $chan ) && ( $readini(autoset.ini,Setting,Autovo) == On ) && ( $readini(autoset.ini,$chan,Auto) != On ) { .mode $chan +v $nick }
}

menu Channel {
  $iif($readini(autoset.ini,$chan,Auto) != On,AuTo Set[#])
  .-
  .조인인사[ $+ $iif($readini(autoset.ini,Setting,Joinme) == $null,Off,$readini(autoset.ini,Setting,Joinme)) $+ ] {
    if ( $readini(autoset.ini,Setting,Joinme) == On ) { writeini autoset.ini Setting Joinme Off }
    else { writeini autoset.ini Setting Joinme On }
  }
  .인사메세지[ $+ $iif($readini(autoset.ini,Setting,Joinmem) == $null,없음,$readini(autoset.ini,Setting,Joinmem)) $+ ] { writeini autoset.ini Setting Joinmem $input(조인인사메세지,1) }
  .-
  .환영인사[ $+ $iif($readini(autoset.ini,Setting,Join) == $null,Off,$readini(autoset.ini,Setting,Join)) $+ ] {
    if ( $readini(autoset.ini,Setting,Join) == On ) { writeini autoset.ini Setting Join Off }
    else { writeini autoset.ini Setting Join On }
  }
  .환영메세지[ $+ $iif($readini(autoset.ini,Setting,Joinm) == $null,없음,$readini(autoset.ini,Setting,Joinm)) $+ ] { writeini autoset.ini Setting Joinm $input(환영인사메세지,1) }
  .-
  .오토옵[ $+ $iif($readini(autoset.ini,Setting,Autoop) == $null,Off,$readini(autoset.ini,Setting,Autoop)) $+ ] {
    if ( $readini(autoset.ini,Setting,Autoop) == On ) { writeini autoset.ini Setting Autoop Off }
    else { writeini autoset.ini Setting Autoop On }
  }
  .오토보이스[ $+ $iif($readini(autoset.ini,Setting,Autovo) == $null,Off,$readini(autoset.ini,Setting,Autovo)) $+ ] {
    if ( $readini(autoset.ini,Setting,Autovo) == On ) { writeini autoset.ini Setting Autovo Off }
    else { writeini autoset.ini Setting Autovo On }
  }
  .-
  .채널따로설정으로 { writeini autoset.ini $chan Auto On }
  .-
  -
  $iif($readini(autoset.ini,$chan,Auto) == On,AuTo Set[ $+ $chan $+ ])
  .-
  .조인인사[ $+ $iif($readini(autoset.ini,$chan,Joinme) == $null,Off,$readini(autoset.ini,$chan,Joinme)) $+ ] {
    if ( $readini(autoset.ini,$chan,Joinme) == On ) { writeini autoset.ini $chan Joinme Off }
    else { writeini autoset.ini $chan Joinme On }
  }
  .인사메세지[ $+ $iif($readini(autoset.ini,$chan,Joinmem) == $null,없음,$readini(autoset.ini,$chan,Joinmem)) $+ ] { writeini autoset.ini $chan Joinmem $input(조인인사메세지,1) }
  .-
  .환영인사[ $+ $iif($readini(autoset.ini,$chan,Join) == $null,Off,$readini(autoset.ini,$chan,Join)) $+ ] {
    if ( $readini(autoset.ini,$chan,Join) == On ) { writeini autoset.ini $chan Join Off }
    else { writeini autoset.ini $chan Join On }
  }
  .환영메세지[ $+ $iif($readini(autoset.ini,$chan,Joinm) == $null,없음,$readini(autoset.ini,$chan,Joinm)) $+ ] { writeini autoset.ini $chan Joinm $input(환영인사메세지,1) }
  .-
  .오토옵[ $+ $iif($readini(autoset.ini,$chan,Autoop) == $null,Off,$readini(autoset.ini,$chan,Autoop)) $+ ] {
    if ( $readini(autoset.ini,$chan,Autoop) == On ) { writeini autoset.ini $chan Autoop Off }
    else { writeini autoset.ini $chan Autoop On }
  }
  .오토보이스[ $+ $iif($readini(autoset.ini,$chan,Autovo) == $null,Off,$readini(autoset.ini,$chan,Autovo)) $+ ] {
    if ( $readini(autoset.ini,$chan,Autovo) == On ) { writeini autoset.ini $chan Autovo Off }
    else { writeini autoset.ini $chan Autovo On }
  }
  .-
  .전체채널설정으로 { writeini autoset.ini $chan Auto Off }
  .-
  자동조인설정: {  /dialog -ma Autojoin_Controler Autojoin_Controler }
  토픽변경 : { ST $chan }
}
;; 검색툴
alias -l mirc_tool_mdx { 
  var %dll = $mircdirscripts\mdx.dll   
  return $dll(%dll,$1,$2-) 
} 

dialog mirc_tool {
  title "mirc_tool"
  size -1 -1 192 10
  option dbu
  edit "", 1, 101 0 56 10, autohs
  combo 2, 0 0 47 50, size drop
  combo 3, 48 0 52 50, size drop
  button "검색", 4, 158 0 34 10, ok
}

on *:dialog:mirc_tool:init:0:{ 
  mirc_tool_mdx SetMircVersion $version 
  mirc_tool_mdx MarkDialog $dname 
  mirc_tool_mdx SetColor $dname 1 text $rgb( 0 , 0 , 0 )
  mirc_tool_mdx SetColor $dname 2 text $rgb( 15 , 100 , 240 )
  mirc_tool_mdx SetColor $dname 3 text $rgb( 69 , 192 , 63 )
  mirc_tool_mdx SetColor $dname 1,2,3 background $rgb( 255 , 255 , 255 )
  mirc_tool_mdx SetColor $dname 1,2,3 textbg $rgb( 255  , 255 , 255 )
}

on 1:dialog:mirc_tool:*:*: {
  if ( $devent == sclick ) {
    if ( $did == 2 ) { 
      if ( $did(mirc_tool,2).sel == 1 ) {
        did -r mirc_tool 3 
        did -i mirc_tool 3 1 네이버
        did -i mirc_tool 3 2 엠파스
        did -i mirc_tool 3 3 구글
        did -i mirc_tool 3 4 야후
        did -i mirc_tool 3 5 다음
        did -c mirc_tool 3 1
      }
      if ( $did(mirc_tool,2).sel == 2 ) {
        did -r mirc_tool 3 
        did -i mirc_tool 3 1 야후
        did -i mirc_tool 3 2 엠파스
        did -c mirc_tool 3 1
      }
      if ( $did(mirc_tool,2).sel == 3 ) {
        did -r mirc_tool 3 
        did -i mirc_tool 3 1 매일경제
        did -c mirc_tool 3 1
      }
      if ( $did(mirc_tool,2).sel == 4 ) {
        did -r mirc_tool 3 
        did -i mirc_tool 3 1 마이폴더
        did -c mirc_tool 3 1
      }
    }
    if ( $did == 4 ) {
      unset %tool_key
      set %tool_key $did(mirc_tool,1)
      if ( $did(mirc_tool,2).sel == 1 ) {
        if ( $did(mirc_tool,3).sel == 1 ) { run explorer "http://search.naver.com/search.naver?where=3&oldquery=&restrict=0&field=0&host=&dir=&homepage=0&display=10&start=1&query= $+ %tool_key $+ " }
        if ( $did(mirc_tool,3).sel == 2 ) { run explorer "http://search.empas.com/search/all.html?s=s&e=1&n=10&q= $+ %tool_key $+ " }
        if ( $did(mirc_tool,3).sel == 3 ) { run explorer "http://www.google.co.kr/search?q= $+ %tool_key $+ " }
        if ( $did(mirc_tool,3).sel == 4 ) { run explorer "http://kr.search.yahoo.com/bin/search?p= $+ %tool_key $+ " }
        if ( $did(mirc_tool,3).sel == 5 ) { run explorer "http://search.daum.net/cgi-bin/nsp/search.cgi?nil_profile=g&nil_Search=btn&oldw=&sw=tot&q= $+ %tool_key $+ " }
      }
      if ( $did(mirc_tool,2).sel == 2 ) {
        if ( $did(mirc_tool,3).sel == 1 ) { run explorer "http://kr.engdic.yahoo.com/search/engdic?p= $+ %tool_key $+ " }
        if ( $did(mirc_tool,3).sel == 2 ) { run explorer "http://engdic.empas.com/show.tsp/?s=e&q= $+ %tool_key $+ " }
      }
      if ( $did(mirc_tool,2).sel == 3 ) {
        if ( $did(mirc_tool,3).sel == 1 ) { run explorer "http://find.mk.co.kr/fcgi-bin/search.fcgi?search= $+ %tool_key $+ " }
      }
      if ( $did(mirc_tool,2).sel == 4 ) {
        if ( $did(mirc_tool,3).sel == 1 ) { run explorer "http://software.myfolder.net/Search/?q= $+ %tool_key $+ " }
      }
    }
  }
}

alias -l mirc_tool_start {
  unset %tool_key
  dialog -ma mirc_tool mirc_tool 
  did -r mirc_tool 2
  did -i mirc_tool 2 1 검색 엔진
  did -i mirc_tool 2 2 영어 사전
  did -i mirc_tool 2 3 신문 검색
  did -i mirc_tool 2 4 S/W  검색
  did -c mirc_tool 2 1
  did -r mirc_tool 3
  did -i mirc_tool 3 1 네이버
  did -i mirc_tool 3 2 엠파스
  did -i mirc_tool 3 3 구글 
  did -i mirc_tool 3 4 야후
  did -i mirc_tool 3 5 다음 
  did -c mirc_tool 3 1
}

alias topicgo {
  tokenize 32 $strip($1-)
  /say 14Connect :12 $chan($chan).topic 14서버로 접속합니다.  $logo  
  run steam://connect/ $+ $replace($remove($1-,$3-,;password  ), $2 , / $+ $2)
  if ( %ingametray == 1 ) {
    /showmirc -n
  }
}
alias hltopicgo {
  tokenize 32 $strip($1-)
  /say 4HLTV :12 $chan($chan).topic 14서버로 접속합니다.  $logo  
  run %hltvdir +connect $remove($1,;password) +serverpassword $2
}
alias sxego {
  set %tempwin $dll(mirc_Windows.dll,fuGetTitle,)
  sxetimer %tempwin
}

alias sxetimer {
  if ( $1 != sXe && $2 != Injected ) {
    .timersxe 0 1 sxego
  }
  elseif ( $1 == sXe && $2 == Injected && $3 != $null ) {
    topicgo $chan($chan).topic
    .timersxe off
    .timerantiflood off
    deltempwin
    /showmirc -n
  }
  else {
    .timersxe 0 1 sxego
  }
}
