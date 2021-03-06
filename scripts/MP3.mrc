
alias -l mdx {   
  return $dll($mircdirscripts\mdx.dll,$1,$2-) 
} 
alias mp3_p { 
  dialog -ma mp3_ogg mp3_ogg
}
dialog mp3_ogg {
  title "Mp3_Ogg Player"
  size -1 -1 160 190
  option dbu
  edit "" 8, 62 3 91 8, autohs read
  text "Kbps", 15, 76 14 15 9
  edit "" 17, 62 13 14 7, autohs center
  text "㎑", 19, 101 14 10 9
  edit "" 18, 91 13 10 7, autohs center
  edit "00:00", 1, 7 3 50 17, autohs center
  button "◀◀", 2, 6 36 17 10
  button "▶", 3, 24 36 17 10
  button "▥", 4, 42 36 17 10
  button "■", 5, 60 36 17 10
  button "▶▶", 6, 78 36 17 10
  button "플레이어 숨기기", 609, 103 35 50 10
  list 7, 3 23 155 12, size
  list 16, 7 54 147 117, size 
  box "*----------------- Play List ------------------*", 9, 5 47 151 127
  button "파일추가", 10, 3 175 37 12
  button "폴더추가", 11, 42 175 37 12
  button "선택삭제", 12, 82 175 37 12
  button "목록삭제", 13, 121 175 37 12
  list 14, 108 11 50 12, size
  menu "파일" 53,
  menu "옵션" 55,
  menu "재생방식" 100, 55
  item "연속재생", 101, 55 
  item "랜덤재생", 102, 55 
  menu "플레이 중인 곡 알리기" 56, 55
  item "채널에게" 58,56
  item "자신에게만" 59,56
  item break, 60,56
  item "켬" 61,56
  item "끔" 62,56 
  item "숨기기" 72, 53
  item "닫기" 54, 53
  menu "도움말" 103,
  item "경로문제.." 104, 103
}
on *:dialog:mp3_ogg:init:0:{
  mdx SetMircVersion $version 
  mdx MarkDialog $dname 
  mdx SetControlMDX $dname 7 trackbar noticks > $mircdirscripts\bars.mdx 
  mdx SetControlMDX $dname 14 trackbar noticks > $mircdirscripts\bars.mdx 
  mdx SetBorderStyle $dname 7,14
  mdx SetFont $dname 1 ANSI 30 400 Tahoma 
  mdx SetFont $dname 17,18,8 ANSI 12 400 Tahoma 
  mdx SetFont $dname 16 ANSI 13 500 Tahoma
  mdx SetColor $dname 1,17,18,8,16 background $rgb(255,255,255)
  mdx SetColor $dname 1,17,18,8,16 textbg $rgb(255,255,255) 
  mdx SetColor $dname 1,17,18,8,16 text $rgb(0,0,0) 
  did -i $dname 14 1 params $vol(master) 0 65535
  if ($insong.fname != $null) { did -ra mp3_ogg 8 $nopath($insong.fname) $+ ( $+ $gmt($calc($sound($insong.fname).length /1000),n:ss) $+ ) }
  if (%mp3_random == on) { did -c mp3_ogg 102 }
  if (%mp3_contin == on) { did -c mp3_ogg 101 }
  if (%mp3_adver == msg) { did -c mp3_ogg 58 }
  if (%mp3_adver == echo) { did -c mp3_ogg 59 }
  if (%mp3_adver_sw == on) { did -c mp3_ogg 61 }
  if (%mp3_adver_sw == off) { did -c mp3_ogg 62 }
  if ($insong.fname == $null) { unset %mp3play_th }
  playlist_load
  set %mp3_pause off
  echo -a 1‥4#uFo 12iRC1‥12MP3 Player On.
}
on *:DIALOG:mp3_ogg:sclick:11 {
  set %mp3_dir $sdir="음악이 있는 폴더를 지정해주세요." C:\
  mp3_list
}
on *:DIALOG:mp3_ogg:sclick:2 {
  prev
}
on *:DIALOG:mp3_ogg:sclick:3 {
  splay stop
  set %mp3play $read(playlist.txt, $did(mp3_ogg,16).sel)
  set %mp3play_th $readn
  mp3_play
}
on *:DIALOG:mp3_ogg:sclick:4 {
  if (%mp3_pause == off) {
    set %mp3_pause on
    splay pause
  }
  else {
    set %mp3_pause off
    splay resume
  }
}
on *:DIALOG:mp3_ogg:sclick:5 {
  stop_s
}
on *:DIALOG:mp3_ogg:sclick:6 {
  next
}
on *:DIALOG:mp3_ogg:sclick:13 {
  write -c playlist.txt 
  did -r $dname 16 
}
on *:DIALOG:mp3_ogg:sclick:14 {
  var %t = $vol_c(14)
  vol -v $calc(65535 - %t)
}
on *:DIALOG:mp3_ogg:menu:72 {
  dialog -x mp3_ogg mp3_ogg
  echo -a 1‥4uFo 12IRC1‥12MP3 Player Hide.
}
on *:DIALOG:mp3_ogg:menu:102 {
  if (%mp3_random == on) {
    set %mp3_random off
    did -u mp3_ogg 102
  }
  else {
    set %mp3_random on
    did -c mp3_ogg 102
  }
}
on *:DIALOG:mp3_ogg:menu:101 {
  if (%mp3_contin == on) {
    set %mp3_contin off
    did -u mp3_ogg 101
  }
  else {
    set %mp3_contin on
    did -c mp3_ogg 101
  }
}
on *:DIALOG:mp3_ogg:menu:54 {
  dialog -c mp3_ogg mp3_ogg
}
on *:DIALOG:mp3_ogg:menu:58 {
  set %mp3_adver msg
  did -u mp3_ogg 57
  did -c mp3_ogg 58
  did -u mp3_ogg 59
}
on *:DIALOG:mp3_ogg:menu:59 {
  set %mp3_adver echo
  did -u mp3_ogg 57
  did -u mp3_ogg 58
  did -c mp3_ogg 59
}
on *:DIALOG:mp3_ogg:menu:61 {
  set %mp3_adver_sw on
  did -u mp3_ogg 62
  did -c mp3_ogg 61
}
on *:DIALOG:mp3_ogg:menu:62 {
  set %mp3_adver_sw off
  did -u mp3_ogg 61
  did -c mp3_ogg 62
}
on *:DIALOG:mp3_ogg:menu:104 {
  echo -a 4Playlist.txt 파일안 경로가 잘못되었다 나오는 경우
  echo -a 4[1] 설정된 파일이름이 띄어쓰기가 연속해서 2번이상 들어가 있는지 확인후 고칩니다.
  echo -a 4[2] 설정된 파일이름이 0kb(유령파일) 인지 확인후 (삭제합니다.)
}
on *:dialog:mp3_ogg:sclick:16 {
  did -ra mp3_ogg 8 $nopath($read(playlist.txt, $did(mp3_ogg,16).sel))
}
on *:dialog:mp3_ogg:dclick:16 {
  splay stop
  set %mp3play $read(playlist.txt, $did(mp3_ogg,16).sel)
  set %mp3play_th $readn
  mp3_play
}
on *:DIALOG:mp3_ogg:sclick:7 {
  if (!$insong) { halt } 
  var %p = $did(7).seltext 
  if ($gettok(%p,9,32) == end) { 
    did -i $dname 14 1 params $gettok(%p,1,32) 
    splay seek $insong.fname $gettok(%p,1,32) 
  }
}
on *:DIALOG:mp3_ogg:sclick:609 {
  dialog -x mp3_ogg mp3_ogg
  echo -a 1‥4uFo 12IRC1‥12MP3 Player Hide.
}
on *:DIALOG:mp3_ogg:close:* {
  splay stop
  timerINSONG OFF
  unset %mp3play_th
  echo -a 1‥4uFo 12IRC1‥12MP3 Player Off
}
alias playlist_load { 
  did -r mp3_ogg 16
  var %i2 = $lines(playlist.txt) 
  var %i = 1 
  while (%i <= %i2) { 
    did -a mp3_ogg 16 $left($nopath($read(playlist.txt,%i)),-4)
    inc %i 1 
  } 
}
alias mp3_list {
  .echo -q $findfile(%mp3_dir,*.mp3,0,write playlist.txt $1-)
  .echo -q $findfile(%mp3_dir,*.ogg,0,write playlist.txt $1-)
  playlist_load
}
alias -l vol_c return $calc(65535 - $gettok($did($dname,$1,1).text,1,32))
alias -l timer_sx    { .timerINSONG off }
alias -l timer_s    { .timerINSONG 0 1 music_time }
alias -l music_time { 
  if ($dialog(mp3_ogg)) {
    if ($insong) { 
      did -ra mp3_ogg 1 $gmt($calc($insong.fname.pos /1000),nn:ss) 
      did -i mp3_ogg 7 1 params $calc($insong.pos +1000) 0 $insong.length 5 * * * 
    } 
    else { stop_s } 
  } 
}
alias -l stop_s { 
  did -i mp3_ogg 7 1 params 0 
  splay stop 
  timer_sx  
  did -ra mp3_ogg 1 00:00 
  did -r mp3_ogg 17
  did -r mp3_ogg 18
}
alias mp3_play {
  if ($isfile(%mp3play) == $true) { 
    splay %mp3play 
    mp3_advertise
    if ($dialog(mp3_ogg) != $null) {
      did -ra mp3_ogg 8 $nopath($insong.fname) $+ ( $+ $gmt($calc($sound($insong.fname).length /1000),n:ss) $+ )
      did -ra mp3_ogg 17 $sound($insong.fname).bitrate
      did -ra mp3_ogg 18 $round($calc($sound($insong.fname).sample  /1000),0)
    }
    timer_s  
  }
  else if ($isfile(%mp3play) != $true) { 
    echo -a $mini 4 $+ $mircdirplaylist.txt 파일안 파일경로가 잘못되었습니다. 파일이름을 확인해 보세요
  }
}
on *:dialog:mp3_ogg:sclick:10 {
  set %mp3_add $dir="음악파일을 선택하세요." c:\
  write playlist.txt %mp3_add
  set %mp3_add $left($nopath(%mp3_add),-4)
  did -a mp3_ogg 16 %mp3_add
}
on *:dialog:mp3_ogg:sclick:12 {
  if ($did(mp3_ogg,16).seltext == $null) { echo -a $mini 4 $+ 삭제할 mp3 파일을 목록에서 선택해 주세요. }
  else if ($did(mp3_ogg,16).seltext != $null) {
    write -dl $+ $did(mp3_ogg,16).sel playlist.txt
    did -d mp3_ogg 16 $did(mp3_ogg,16,1).sel
  }
}
on *:mp3end:{ 
  if (%mp3_contin == on) {
    if (%mp3_random == on) { 
      set %mp3play $read(playlist.txt) 
      /mp3_play %mp3play
    } 
    else if (%mp3_random == off) {
      if ($calc(%mp3play_th + 1) > $lines(playlist.txt)) {
        set %mp3play $read(playlist.txt,1)
        set %mp3play_th 1
      }
      else {
        set %mp3play $read(playlist.txt, $calc(%mp3play_th + 1))
        inc %mp3play_th 1
      }
      /mp3_play %mp3play
    }
  }
}
alias mp3_advertise {
  if (%mp3_adver_sw == on) {
    if (%mp3_adver == msg) {
      /msg $active 1‥4uFo 12IRC1‥ 3M_Playing14 :12 $nopath($insong.fname) 14[5 $gmt($calc($insong.fname.length /1000),n:ss) 14/7 $sound($insong.fname).bitrate 12Kbps14 /3 $round($calc($sound($insong.fname).sample  /1000),0) 12kHz 14]
    }
    else if (%mp3_adver == echo) {
      /echo -a 1‥4uFo 12IRC1‥ 3M_Playing14 :12 $nopath($insong.fname) 14[5 $gmt($calc($insong.fname.length /1000),n:ss) 14/7 $sound($insong.fname).bitrate 12Kbps14 /3 $round($calc($sound($insong.fname).sample  /1000),0) 12kHz 14]
    }
  }
}
alias prev {
  if ($insong == $true) {
    splay stop
    if ($calc(%mp3play_th - 1) <= 0) {
      set %mp3play $read(playlist.txt,$lines(playlist.txt))
      set %mp3play_th $lines(playlist.txt)
    }
    else {
      set %mp3play $read(playlist.txt, $calc(%mp3play_th - 1))
      dec %mp3play_th 1
    }
    /mp3_play
  }
  else { echo -a $mini 4음악파일이 실행중이지 않습니다. }
}
alias next {
  if ($insong == $true) {
    splay stop
    if ($calc(%mp3play_th + 1) > $lines(playlist.txt)) {
      set %mp3play $read(playlist.txt,1)
      set %mp3play_th 1
    }
    else {
      set %mp3play $read(playlist.txt, $calc(%mp3play_th + 1))
      inc %mp3play_th 1
    }
    /mp3_play
  }
  else { echo -a $mini 4음악파일이 실행중이지 않습니다. }
}
