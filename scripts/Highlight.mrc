
dialog highlight {
  title "Highlight & 자동반응 Controller"
  size -1 -1 190 98
  option dbu
  tab "설정창", 1,  4 0 182 95
  button "설정 초기화", 37, 10 70 50 12, tab 1
  box "스위치", 500, 8 18 30 40, tab 1
  radio "켜짐", 38, 12 27 22 8, tab 1
  radio "꺼짐", 39, 12 39 22 8, tab 1
  box "제작자 정보", 40, 50 18 125 40, tab 1
  text "Copyright ⓒ 2005, TeamcrazY. LujeK-_-v", 41, 54 48 124 8, tab 1
  text "!호출정보 ,!호출경로를 애용해주세요. ", 42, 54 28 120 20, tab 1
  text "", 43, 0 38 00 8, tab 1
  tab "자기닉", 2
  box "호출설정", 6, 10 17 130 73, tab 2
  text "반응할 단어", 8, 14 27 36 8, tab 2
  edit "", 10, 14 37 120 10, tab 2 read
  text "출력할 말", 9, 14 57 36 8, tab 2
  edit "", 12, 14 67 120 10, tab 2 autohs set %light1
  check "메모출력", 7,145 20 33 8, tab 2
  button "사운드 설정", 44, 145 36 37 12, tab 2
  tab "호출2", 3
  box "호출설정", 13, 10 17 130 73, tab 3
  text "반응할 단어", 17, 14 27 36 8, tab 3
  edit "", 18, 14 37 120 10, tab 3 autohs set %high2
  text "출력할 말", 19, 14 57 36 8, tab 3
  edit "", 20, 14 67 120 10, tab 3 autohs set %light2
  check "메모출력", 33, 145 20 33 8, tab 3
  button "사운드 설정", 45, 145 36 37 12, tab 3
  tab "호출3", 4
  box "호출설정", 14, 10 17 130 73, tab 4
  text "반응할 단어", 21, 14 27 36 8, tab 4
  edit "", 22, 14 37 120 10, tab 4 autohs set %high3
  text "출력할 말", 23, 14 57 36 8, tab 4
  edit "", 24, 14 67 120 10, tab 4 autohs set %light3
  check "메모출력", 34, 145 20 33 8, tab 4
  button "사운드 설정", 46, 145 36 37 12, tab 4
  tab "호출4", 5
  box "호출설정", 15, 10 17 130 73, tab 5
  text "반응할 단어", 25, 14 27 36 8, tab 5
  edit "", 26, 14 37 120 10, tab 5 autohs set %high4
  text "출력할 말", 27, 14 57 36 8, tab 5
  edit "", 28, 14 67 120 10, tab 5 autohs set %light4
  check "메모출력", 35, 145 20 33 8, tab 5
  button "사운드 설정", 47, 145 36 37 12, tab 5
  tab "호출5", 11
  box "호출설정", 16, 10 17 130 73, tab 11
  text "반응할 단어", 29, 14 27 36 8, tab 11
  edit "", 30, 14 37 120 10, tab 11 autohs set %high5
  text "출력할 말", 31, 14 57 36 8, tab 11
  edit "", 32, 14 67 120 10, tab 11 autohs set %light5
  check "메모출력", 36, 145 20 33 8, tab 11
  button "사운드 설정", 48, 145 36 37 12, tab 11
  button "닫    기", 55, 145 70 37 12, ok 
}
on *:dialog:highlight:*:*:{
  if ($devent == init) {
    did -ra highlight 10 $me
    did -ra highlight 12 %light1
    did -ra highlight 18 %high2
    did -ra highlight 20 %light2
    did -ra highlight 22 %high3
    did -ra highlight 24 %light3
    did -ra highlight 26 %high4
    did -ra highlight 28 %light4
    did -ra highlight 30 %high5
    did -ra highlight 32 %light5
    if (%switch == 켜짐) { did -c highlight 38 }
    if (%switch == $null) { did -c highlight 39 }
    if (%memomsg1 == 켜짐) { did -c highlight 7 }
    if (%memomsg1 == $null) { did -u highlight 7 }
    if (%memomsg2 == 켜짐) { did -c highlight 33 }
    if (%memomsg2 == $null) { did -u highlight 33 }
    if (%memomsg3 == 켜짐) { did -c highlight 34 }
    if (%memomsg3 == $null) { did -u highlight 34 }
    if (%memomsg4 == 켜짐) { did -c highlight 35 }
    if (%memomsg4 == $null) { did -u highlight 35 }
    if (%memomsg5 == 켜짐) { did -c highlight 36 }
    if (%memomsg5 == $null) { did -u highlight 36 }
  }
  if ( $devent == sclick ) {
    if ( $did == 38 ) { set %switch 켜짐 
      halt
    }
    if ( $did == 39 ) { unset %switch
      halt
    }
    if ($did == 7) { 
      if (%memomsg1 == $null) { set %memomsg1 켜짐 } 
      else { unset %memomsg1 }
      halt
    }
    if ($did == 33) { 
      if (%memomsg2 == $null) { set %memomsg2 켜짐 } 
      else { unset %memomsg2 }
      halt
    }
    if ($did == 34) { 
      if (%memomsg3 == $null) { set %memomsg3 켜짐 } 
      else { unset %memomsg3 }
      halt
    }
    if ($did == 35) { 
      if (%memomsg4 == $null) { set %memomsg4 켜짐 } 
      else { unset %memomsg4 }
      halt
    }
    if ($did == 36) { 
      if (%memomsg5 == $null) { set %memomsg5 켜짐 } 
      else { unset %memomsg5 }
      halt
    }
    if ( $did == 44 ) { set %hlsound1 $sfile($mircdirSOUNDS\,호출시 실행할 사운드를 선택하세요,열기)
      halt
    }
    if ( $did == 45 ) { set %hlsound2 $sfile($mircdirSOUNDS\,호출시 실행할 사운드를 선택하세요,열기)
      halt
    }
    if ( $did == 46 ) { set %hlsound3 $sfile($mircdirSOUNDS\,호출시 실행할 사운드를 선택하세요,열기)
      halt
    }
    if ( $did == 47 ) { set %hlsound4 $sfile($mircdirSOUNDS\,호출시 실행할 사운드를 선택하세요,열기)
      halt
    }
    if ( $did == 48 ) { set %hlsound5 $sfile($mircdirSOUNDS\,호출시 실행할 사운드를 선택하세요,열기)
      halt
    }
    if ( $did == 37 ) { unset %hlsound* | unset %high* | unset %light* | unset %memomsg* | unset %switch | did -ra highlight 10 $me | did -ra highlight 18 %high2 | did -ra highlight 22 %high3 | did -ra highlight 26 %high4 | did -ra highlight 30 %high5 | did -ra highlight 12 %light1 | did -ra highlight 20 %light2 | did -ra highlight 24 %light3 | did -ra highlight 28 %light4 | did -ra highlight 32 %light5 | did -u highlight 7 | did -u highlight 33 | did -u highlight 34 | did -u highlight 35 | did -u highlight 36 | did -u highlight 38 | did -c highlight 39 
      halt
    }
  }
}
on *:input:#: {
  if ( $1- == !호출 ) {
    say $1
    echo -a 14사용법은 12!사용법 14하시면 나옵니다.
    msg $chan 14Dialog 7Loading ...14 ［ 3호출&자동반응 Controller14 ］─━━━━ $logo
    dialog -ma highlight highlight
    halt
  }
}

on *:text:*:#: { 
  if ( $me isin $1- ) {
    if ( %switch != 켜짐 ) return 
    if ( %memomsg1 == $null ) {
      msg $chan %light1 
    }
    if ( %memomsg1 == 켜짐 ) {
      msg $chan %light1 0,8/0,7/0,4/14 메모 : %memo 0,4/0,7/0,8/
    }
    if ( %hlsound1 == $null ) return {
      splay %hlsound1
      echo -a 1-4알림1-7 $chan 1에서14 $nick 1님의 호출.
    }
  }
  else if ( %high2 isin $1- ) {
    if ( %switch != 켜짐 ) return
    if ( %high2 == $null ) return 
    if ( %memomsg2 == $null ) {
      msg $chan %light2 
    }
    if ( %memomsg2 == 켜짐 ) {
      msg $chan %light2 0,8/0,7/0,4/14 메모 : %memo 0,4/0,7/0,8/
    }
    if ( %hlsound2 == $null ) return {
      splay %hlsound2
      echo -a 1-4알림1-7 $chan 1에서14 $nick 1님의 호출.
    }
  }
  else if ( %high3 isin $1- ) {
    if ( %switch != 켜짐 ) return
    if ( %high3 == $null ) return 
    if ( %memomsg3 == $null ) {
      msg $chan %light3 
    }
    if ( %memomsg3 == 켜짐 ) {
      msg $chan %light3 0,8/0,7/0,4/14 메모 : %memo 0,4/0,7/0,8/
    }
    if ( %hlsound3 == $null ) return {
      splay %hlsound3
      echo -a 1-4알림1-7 $chan 1에서14 $nick 1님의 호출.
    }
  }
  else if ( %high4 isin $1- ) {
    if ( %switch != 켜짐 ) return
    if ( %high4 == $null ) return 
    if ( %memomsg4 == $null ) {
      msg $chan %light4 
    }
    if ( %memomsg4 == 켜짐 ) {
      msg $chan %light4 0,8/0,7/0,4/14 메모 : %memo 0,4/0,7/0,8/
    }
    if ( %hlsound4 == $null ) return {
      splay %hlsound4
      echo -a 1-4알림1-7 $chan 1에서14 $nick 1님의 호출.
    }
  }
  else if ( %high5 isin $1- ) {
    if ( %switch != 켜짐 ) return
    if ( %high5 == $null ) return 
    if ( %memomsg5 == $null ) {
      msg $chan %light5 
    }
    if ( %memomsg5 == 켜짐 ) {
      msg $chan %light5 0,8/0,7/0,4/14 메모 : %memo 0,4/0,7/0,8/
    }
    if ( %hlsound5 == $null ) return {
      splay %hlsound5
      echo -a 1-4알림1-7 $chan 1에서14 $nick 1님의 호출.
    }
  }
}
