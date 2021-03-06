dialog config {
  title "설정 - ddos.hanirc.org #uFo AmiE"
  size -1 -1 190 199
  option dbu
  tab "닉네임", 1, 1 0 188 196
  edit "", 7, 27 53 52 10, tab 1
  text "1차 닉네임", 8, 27 39 33 8, tab 1
  edit "", 11, 25 103 137 10, tab 1 autohs
  text "말머리", 12, 25 90 25 8, tab 1
  text "꼬릿말", 13, 24 120 25 8, tab 1
  edit "", 9, 109 53 52 10, tab 1
  text "2차 닉네임", 10, 109 39 33 8, tab 1
  edit "", 14, 24 133 137 10, tab 1 autohs
  box "닉네임", 16, 19 31 153 41, tab 1
  box "말머리 꼬릿말 - !닉 으로 활성화", 17, 17 79 159 73, tab 1
  button "Save", 61, 93 180 37 12, tab 1
  tab "호출", 2
  box "호출 반응", 18, 12 20 164 74, tab 2
  check "호출 경로", 20, 19 28 41 10, tab 2 left
  text "호출을 한 사람과 채널을 표시 해줍니다.", 21, 19 38 146 10, tab 2
  box "반응 관련", 25, 12 100 164 72, tab 2
  edit "", 26, 19 150 149 10, tab 2
  text "메모", 27, 19 138 17 8, tab 2
  text "부재중", 28, 19 112 23 8, tab 2
  check "호출 정보", 23, 19 50 41 10, tab 2 left
  text "호출 받을 시 자신의 최상위 윈도우를 표시 해줍니다.", 24, 19 60 146 10, tab 2
  edit "", 29, 19 123 149 10, tab 2
  check "아얄씨 종료시 부재중 내용 초기화", 19, 49 110 100 11, tab 2 left
  check "부재중 표시", 22, 19 71 41 10, tab 2 left
  text "호출 받을 시 부재중 내용을 표시 해줍니다.", 60, 19 81 146 10, tab 2
  check "아얄씨 종료시 메모 내용 초기화", 5, 55 136 94 11, tab 2 left
  button "Save", 6, 93 180 37 12, tab 2
  tab "빵글이", 3
  box "빵글이 로그인", 30, 19 59 134 69, tab 3
  check "사용하기", 31, 25 69 38 10, tab 3
  text "아이디", 32, 25 86 24 8, tab 3 center
  edit "", 33, 51 86 58 10, tab 3
  text "비밀번호", 34, 25 102 24 8, tab 3
  edit "", 35, 51 102 58 10, tab 3 pass autohs
  button "로그인", 36, 111 85 37 12, tab 3
  button "회원가입", 37, 111 100 37 12, tab 3
  check "아이피 숨기기", 38, 81 69 50 10, tab 3
  tab "경로 설정", 4
  box "Steam", 39, 12 22 150 36, tab 4
  edit "", 40, 16 30 139 10, tab 4 autohs
  button "수동 설정", 41, 16 42 37 12, tab 4
  button "자동 설정", 42, 66 42 37 12, tab 4
  button "경로 삭제", 43, 116 42 37 12, tab 4
  box "sXe - Injected", 44, 12 61 150 36, tab 4
  edit "", 48, 16 69 139 10, tab 4 autohs
  button "수동 설정", 45, 16 81 37 12, tab 4
  button "자동 설정", 46, 66 81 37 12, tab 4
  button "경로 삭제", 47, 116 81 37 12, tab 4
  box "HLTV", 49, 12 100 150 36, tab 4
  edit "", 53, 16 108 139 10, tab 4 autohs
  button "수동 설정", 50, 16 120 37 12, tab 4
  button "자동 설정", 51, 66 120 37 12, tab 4
  button "경로 삭제", 52, 116 120 37 12, tab 4
  edit "", 58, 16 148 139 10, tab 4 autohs
  box "Counter Strike : Online", 54, 12 140 150 36, tab 4
  button "수동 설정", 55, 16 160 37 12, tab 4
  button "자동 설정", 56, 66 160 37 12, tab 4
  button "경로 삭제", 57, 116 160 37 12, tab 4
  check "게임 시작시 트레이", 59, 21 181 63 10, tab 4 left
  tab "테러방지", 62
  combo 63, 51 33 60 140, tab 62 size vsbar
  button "채널 추가", 64, 116 33 38 12, tab 62
  button "채널 제거", 65, 116 50 39 12, tab 62
  button "모두 삭제", 66, 116 67 39 12, tab 62
  edit "", 67, 116 83 12 10, tab 62
  text "명 이상", 68, 129 84 21 7, tab 62
  text "호출시 킥밴", 69, 129 92 35 8, tab 62
  text "보이스 :", 72, 122 133 22 8, tab 62 right
  text "노옵 :", 74, 122 142 22 8, tab 62 right
  text " X", 78, 145 142 17 8, tab 62 center
  text " X", 77, 145 133 17 8, tab 62 center
  text " X", 76, 145 124 17 8, tab 62 center
  text " X", 75, 145 115 17 8, tab 62 center
  text "총인원 :", 71, 122 115 22 8, tab 62 right
  text "옵 :", 73, 122 124 22 8, tab 62 right
  box "채널 정보", 70, 119 106 45 50, tab 62
  box "채널 리스트", 80, 46 25 70 150, tab 62
  text " #포함 시켜주세요", 79, 8 33 34 13, tab 62 center
  tab "화면", 81
  icon 82, 13 29 140 108,image\display\1.jpg, tab 81
  radio "1", 83, 164 57 15 10, tab 81
  radio "2", 84, 164 77 15 10, tab 81
  radio "3", 85, 164 98 15 10, tab 81
  text "오른쪽 버튼을 눌러주세요", 87, 15 148 144 25, tab 81
  box "설명", 88, 10 140 155 37, tab 81
  button "Cancel", 15, 139 180 37 12, cancel
}


menu status,channel,menubar,query {
  -
  설정: {
    if (!$dialog(config)) { dialog -md config config | halt }
    dialog -iev config
  }
}
on *:dialog:config:init:0 {
  write -c unterrorlist_l.txt
  write unterrorlist_l.txt $replace($read(unterrorlist.txt),$chr(44),$crlf)
  ;Tab 1
  /did -i config 7 1 %nickdefault
  /did -i config 9 1 %nick2nd
  /did -i config 11 1 $readini(scripts\xircsystem.ini,settings,saytitle)
  /did -i config 14 1 $readini(scripts\xircsystem.ini,settings,sayend)
  ;Tab 2
  /did -i config 29 1 %awaymsg
  /did -i config 26 1 %memo
  if ( %whocall == 1 ) {
    /did -c config 20
  }
  if ( %windows == 1 ) {
    /did -c config 23
  }
  if ( %showaway == 1 ) {
    /did -c config 22
  }
  if ( %delaway == 1 ) {
    /did -c config 19
  }
  if ( %delmemo == 1 ) {
    /did -c config 5
  }
  ;Tab 3
  if ( %bb.ip == on ) {
    /did -c config 38
  }
  if ( %bb.start == on ) {
    /did -c config 31
  }
  /did -i config 33 1 $readini(bb.ini,bb,id)
  /did -i config 35 1 $readini(bb.ini,bb,ps)
  ;Tab 4
  /did -i config 40 1 %steamdir
  /did -i config 48 1 %sxedir
  /did -i config 53 1 %hltvdir
  /did -i config 58 1 %csodir
  if ( %ingametray == 1 ) {
    /did -c config 59
  }
  ;Tab 5
  did -i config 67 1 %unterror.set
  did -r config 63
  var %i 1
  while (%i <= 100) {
    if ($dialog(config)) {
      if ($null != $read(unterrorlist_l.txt,%i)) { /did -a config 63 $read(unterrorlist_l.txt,%i) }
    }
    inc %i
  }
}
;;;;;;;;;;;;;;;;;;종료시;;;;;;;;;;;;;;;;;;;;;;;
on *:dialog:config:sclick:15 {
  set %unterror.set $did(config,67)
}

;;;;;;;;;;;;;;;;;;;;;설정 저장;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;tab1
on *:dialog:config:sclick:61 {
  .nick $did(config,7)
  set %nickdefault $did(config,7)
  .anick $did(config,9)
  set %nick2nd $did(config,9)
  writeini scripts\\xircsystem.ini settings saytitle $did(config,11)
  writeini scripts\\xircsystem.ini settings sayend $did(config,14)
}
;;;;;;;;;;;;;;;;;;;;;;;;;;tab2
on *:dialog:config:sclick:20 {
  if ($did(config,20).state == 1) {
    set %whocall 1
  }
  if ($did(config,20).state == 0) {
    set %whocall 0
  }
}
on *:dialog:config:sclick:23 {
  if ($did(config,23).state == 1) {
    set %windows 1
  }
  if ($did(config,23).state == 0) {
    set %windows 0
  }
}
on *:dialog:config:sclick:22 {
  if ($did(config,22).state == 1) {
    set %showaway 1
  }
  if ($did(config,22).state == 0) {
    set %showaway 0
  }
}
on *:dialog:config:sclick:19 {
  if ($did(config,19).state == 1) {
    set %delaway 1
  }
  if ($did(config,19).state == 0) {
    set %delaway 0
  }
}
on *:dialog:config:sclick:5 {
  if ($did(config,5).state == 1) {
    set %delmemo 1
  }
  if ($did(config,5).state == 0) {
    set %delmemo 0
  }
}
on *:dialog:config:sclick:6 {
  if ( $did(config,29) == $null ) {
    unset %awaymsg
    set %away off
  }
  else {
    set %awaymsg $did(config,29)
  }
  set %memo $did(config,26)
}
;;;;;;;;;;;;;;;;;;;;;;;;;;tab3
on *:dialog:config:sclick:31 {
  if ($did(config,31).state == 1) {
    set %bb.start on
  }
  if ($did(config,31).state == 0) {
    unset %bb.start
  }
}
on *:dialog:config:sclick:38 {
  if ($did(config,38).state == 1) {
    set %bb.ip on
  }
  if ($did(config,38).state == 0) {
    unset %bb.ip
  }
}
on *:dialog:config:sclick:36 {
  /msg ^^ login $did(config,33) $did(config,35)
}
on *:dialog:config:sclick:37 {
  /run http://service.hanirc.org/live/newuser.php
}
;;;;;;;;;;;;;;;;;;;;;;;;;;tab4
on *:dialog:config:sclick:41 {
  searchsteam
}
on *:dialog:config:sclick:42 {
  ss
}
on *:dialog:config:sclick:43 {
  /did -r config 40
  unset %steamdir
}
on *:dialog:config:sclick:46 {
  searchsxe
}
on *:dialog:config:sclick:45 {
  ct
}
on *:dialog:config:sclick:47 {
  /did -r config 48
  unset %sxedir
}
on *:dialog:config:sclick:51 {
  searchhltv
}
on *:dialog:config:sclick:50 {
  hltv
}
on *:dialog:config:sclick:52 {
  /did -r config 53
  unset %hltvdir
}
on *:dialog:config:sclick:56 {
  searchcso
}
on *:dialog:config:sclick:55 {
  cso
}
on *:dialog:config:sclick:57 {
  /did -r config 58
  unset %csodir
}
on *:dialog:config:sclick:59 {
  if ($did(config,59).state == 1) {
    set %ingametray 1
  }
  if ($did(config,59).state == 0) {
    set %ingametray 0
  }
}

;tab 5
on *:dialog:config:sclick:64 {
  if ( $chr(35) isin $did(config,63)) {
    var %tempc = $read(unterrorlist.txt)
    write -c unterrorlist.txt
    write -c unterrorlist_l.txt
    write unterrorlist.txt %tempc $+ $chr(44) $+ $did(config,63)
    write unterrorlist_l.txt $replace($read(unterrorlist.txt),$chr(44),$crlf)
    did -r config 63
    var %i 1
    while (%i <= 100) {
      if ($dialog(config)) {
        if ($null != $read(unterrorlist_l.txt,%i)) { /did -a config 63 $read(unterrorlist_l.txt,%i) }
      }
      inc %i
    }
  }
  else { echo -a [4-X4-]4 #이 포함되어있지 않거나 공백입니다. }
}
on *:dialog:config:sclick:65 {
  if ( $chr(35) isin $did(config,63)) {
    var %i 1
    while (%i <= 100) {
      if ($null != $read(unterrorlist_l.txt,%i)) { 
        if ( $did(config,63) == $read(unterrorlist_l.txt,%i)) {
          write -dl $+ %i  unterrorlist_l.txt
          var %unterrorlist $read(unterrorlist.txt,1)
          write -c unterrorlist.txt
          if ( %unterrorlist != $chr(44) $+ $did(config,63)) {
            write unterrorlist.txt $replace(%unterrorlist,$chr(44) $+ $did(config,63) $+ $chr(44) , $chr(44))
          }
        }
      }
      inc %i
    }
    %i = 1
    did -r config 63
    while (%i <= 100) {
      if ($dialog(config)) {
        if ($null != $read(unterrorlist_l.txt,%i)) { /did -a config 63 $read(unterrorlist_l.txt,%i) }
      }
      inc %i
    }
  }
  else { echo -a [4-X4-]4 #이 포함되어있지 않거나 공백입니다. }
}
on *:dialog:Config:sclick:63:{ 
  did -ra Config 75 　 $+ $nick($did(Config,63).seltext,0)
  did -ra Config 76 　 $+ $opnick($did(Config,63).seltext,0)
  did -ra Config 77 　 $+ $vnick($did(Config,63).seltext,0)
  did -ra Config 78 　 $+ $nopnick($did(Config,63).seltext,0)
}
;화면
on *:dialog:Config:sclick:81:{
  if ( %display == $null ) {
    /did -g config 82 image\display\1.jpg
    /did -c config 83
    /did -ra config 87 기본값입니다. 스위치바 하고 싸이드 트리바를 킴으로 채널선택에 편의성을 가져다줍니다.
  }
  elseif ( %display == 1 ) {
    /did -g config 82 image\display\1.jpg
    /did -c config 83
    /did -ra config 87 기본값입니다. 스위치바 하고 싸이드 트리바를 킴으로 채널선택에 편의성을 가져다줍니다.
  }
  elseif ( %display == 2 ) {
    /did -g config 82 image\display\2.jpg
    /did -c config 84
    /did -ra config 87 제로IRC나 기타아얄씨의 설정입니다. 싸이드 트리바를 끔으로써 채팅창의 공간을 넓힌 디자인입니다.
  }
  elseif ( %display == 3 ) {
    /did -g config 82 image\display\3.jpg
    /did -c config 85
    /did -ra config 87 모든 설정을 끕니다. 오로지 한 채널에만 고수하시는 분들에게 가장 적합한 디자인입니다.
  }
}
on *:dialog:Config:sclick:83:{
  .switchbar on
  .treebar on
  /did -g config 82 image\display\1.jpg
  /did -ra config 87 기본값입니다. 스위치바 하고 싸이드 트리바를 킴으로 채널선택에 편의성을 가져다줍니다.
  set %display 1
}
on *:dialog:Config:sclick:84:{
  .switchbar on
  .treebar off
  /did -g config 82 image\display\2.jpg
  /did -ra config 87 제로IRC나 기타아얄씨의 설정입니다. 싸이드 트리바를 끔으로써 채팅창의 공간을 넓힌 디자인입니다.
  set %display 2
}
on *:dialog:Config:sclick:85:{
  .switchbar off
  .treebar off
  /did -g config 82 image\display\3.JPG
  /did -ra config 87 모든 설정을 끕니다. 오로지 한 채널에만 고수하시는 분들에게 가장 적합한 디자인입니다.
  set %display 3
}














dialog 경고config {
  title "경고!"
  size -1 -1 99 42
  option dbu
  text "이 명령을 수행하게 되면, 설정된 모든 채널이 삭제됩니다. 그래도 계속 하시겠습니까?", 1, 5 5 90 18
  button "네", 2, 4 26 43 12, ok
  button "아니오", 3, 52 26 43 12, cancel
}
on *:dialog:config:sclick:66:{
  /dialog -ma 경고config 경고config
} 
on *:dialog:경고config:sclick:2:{
  /write -c unterrorlist.txt
  /write -c unterrorlist_l.txt
  /did -r config 63
}
on *:dialog:경고config:sclick:3:{
  halt
}
