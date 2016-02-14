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
  text "§Õ", 19, 101 14 10 9
  edit "" 18, 91 13 10 7, autohs center
  edit "00:00", 1, 7 3 50 17, autohs center
  button "¢¸¢¸", 2, 6 36 17 10
  button "¢º", 3, 24 36 17 10
  button "¢Æ", 4, 42 36 17 10
  button "¡á", 5, 60 36 17 10
  button "¢º¢º", 6, 78 36 17 10
  text "mp3_ogg player", 609, 103 38 50 10, disable
  list 7, 3 23 155 12, size
  list 16, 7 54 147 117, size 
  box "*-* Play List *-*", 9, 5 47 151 127
  button "ÆÄÀÏÃß°¡", 10, 3 175 37 12
  button "Æú´õÃß°¡", 11, 42 175 37 12
  button "¼±ÅÃ»èÁ¦", 12, 82 175 37 12
  button "¸ñ·Ï»èÁ¦", 13, 121 175 37 12
  list 14, 108 11 50 12, size
  menu "ÆÄÀÏ" 53,
  menu "¿É¼Ç" 55,
  menu "Àç»ý¹æ½Ä" 100, 55
  item "¿¬¼ÓÀç»ý", 101, 55 
  item "·£´ýÀç»ý", 102, 55 
  menu "ÇÃ·¹ÀÌ ÁßÀÎ °î ¾Ë¸®±â" 56, 55
  item "ÀüÃ¼" 57,56
  item "/Msg" 58,56
  item "/Echo" 59,56
  item break, 60,56
  item "ÄÔ" 61,56
  item "²û" 62,56 
  item "¼û±â±â" 72, 53
  item "´Ý±â" 54, 53
  menu "µµ¿ò¸»" 103,
  item "°æ·Î¹®Á¦.." 104, 103
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
  mdx SetColor $dname 1,17,18,8,16 background $rgb(0,0,0)
  mdx SetColor $dname 1,17,18,8,16 textbg $rgb(0,0,0) 
  mdx SetColor $dname 1,17,18,8,16 text $rgb(255,255,255) 
  did -i $dname 14 1 params $vol(master) 0 65535
  if ($insong.fname != $null) { did -ra mp3_ogg 8 $nopath($insong.fname) $+ ( $+ $gmt($calc($sound($insong.fname).length /1000),n:ss) $+ ) }
  if (%mp3_random == on) { did -c mp3_ogg 102 }
  if (%mp3_contin == on) { did -c mp3_ogg 101 }
  if (%mp3_adver == ame) { did -c mp3_ogg 57 }
  if (%mp3_adver == echo) { did -c mp3_ogg 59 }
  if (%mp3_adver_sw == on) { did -c mp3_ogg 61 }
  if (%mp3_adver_sw == off) { did -c mp3_ogg 62 }
  if ($insong.fname == $null) { unset %mp3play_th }
  playlist_load
  set %mp3_pause off
}
on *:DIALOG:mp3_ogg:sclick:11 {
  set %mp3_dir $sdir="À½¾ÇÀÌ ÀÖ´Â Æú´õ¸¦ ÁöÁ¤ÇØÁÖ¼¼¿ä." C:\
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
on *:DIALOG:mp3_ogg:menu:57 {
  set %mp3_adver ame
  did -c mp3_ogg 57
  did -u mp3_ogg 58
  did -u mp3_ogg 59
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
  echo -a 4Playlist.txt ÆÄÀÏ¾È °æ·Î°¡ Àß¸øµÇ¾ú´Ù ³ª¿À´Â °æ¿ì
  echo -a 4[1] ¼³Á¤µÈ ÆÄÀÏÀÌ¸§ÀÌ ¶ç¾î¾²±â°¡ ¿¬¼ÓÇØ¼­ 2¹øÀÌ»ó µé¾î°¡ ÀÖ´ÂÁö È®ÀÎÈÄ °íÄ¨´Ï´Ù.
  echo -a 4[2] ¼³Á¤µÈ ÆÄÀÏÀÌ¸§ÀÌ 0kb(À¯·ÉÆÄÀÏ) ÀÎÁö È®ÀÎÈÄ (»èÁ¦ÇÕ´Ï´Ù.)
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
on *:DIALOG:mp3_ogg:close:* {
  splay stop
  timerINSONG OFF
  unset %mp3play_th
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
    echo -a $mini 4 $+ $mircdirplaylist.txt ÆÄÀÏ¾È ÆÄÀÏ°æ·Î°¡ Àß¸øµÇ¾ú½À´Ï´Ù. ÆÄÀÏÀÌ¸§À» È®ÀÎÇØ º¸¼¼¿ä
  }
}
on *:dialog:mp3_ogg:sclick:10 {
  set %mp3_add $dir="À½¾ÇÆÄÀÏÀ» ¼±ÅÃÇÏ¼¼¿ä." c:\
  write playlist.txt %mp3_add
  set %mp3_add $left($nopath(%mp3_add),-4)
  did -a mp3_ogg 16 %mp3_add
}
on *:dialog:mp3_ogg:sclick:12 {
  if ($did(mp3_ogg,16).seltext == $null) { echo -a $mini 4 $+ »èÁ¦ÇÒ mp3 ÆÄÀÏÀ» ¸ñ·Ï¿¡¼­ ¼±ÅÃÇØ ÁÖ¼¼¿ä. }
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
    if (%mp3_adver == ame) {
      /ame 1¡¨2TeamcrazY iRc1¡¨ 3M_Playing14 :12 $nopath($insong.fname) 14[5 $gmt($calc($insong.fname.length /1000),n:ss) 14/7 $sound($insong.fname).bitrate 12Kbps14 /3 $round($calc($sound($insong.fname).sample  /1000),0) 12kHz 14]
    }
    else if (%mp3_adver == msg) {
      /msg $active 1¡¨2TeamcrazY iRc1¡¨ 3M_Playing14 :12 $nopath($insong.fname) 14[5 $gmt($calc($insong.fname.length /1000),n:ss) 14/7 $sound($insong.fname).bitrate 12Kbps14 /3 $round($calc($sound($insong.fname).sample  /1000),0) 12kHz 14]
    }
    else if (%mp3_adver == echo) {
      /echo -a 1¡¨2TeamcrazY iRc1¡¨ 3M_Playing14 :12 $nopath($insong.fname) 14[5 $gmt($calc($insong.fname.length /1000),n:ss) 14/7 $sound($insong.fname).bitrate 12Kbps14 /3 $round($calc($sound($insong.fname).sample  /1000),0) 12kHz 14]
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
  else { echo -a $mini 4À½¾ÇÆÄÀÏÀÌ ½ÇÇàÁßÀÌÁö ¾Ê½À´Ï´Ù. }
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
  else { echo -a $mini 4À½¾ÇÆÄÀÏÀÌ ½ÇÇàÁßÀÌÁö ¾Ê½À´Ï´Ù. }
}
