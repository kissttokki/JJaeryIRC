
dialog highlight {
  title "Highlight & ÀÚµ¿¹ÝÀÀ Controller"
  size -1 -1 190 98
  option dbu
  tab "¼³Á¤Ã¢", 1,  4 0 182 95
  button "¼³Á¤ ÃÊ±âÈ­", 37, 10 70 50 12, tab 1
  box "½ºÀ§Ä¡", 500, 8 18 30 40, tab 1
  radio "ÄÑÁü", 38, 12 27 22 8, tab 1
  radio "²¨Áü", 39, 12 39 22 8, tab 1
  box "Á¦ÀÛÀÚ Á¤º¸", 40, 50 18 125 40, tab 1
  text "Copyright ¨Ï 2005, TeamcrazY. LujeK-_-v", 41, 54 48 124 8, tab 1
  text "!È£ÃâÁ¤º¸ ,!È£Ãâ°æ·Î¸¦ ¾Ö¿ëÇØÁÖ¼¼¿ä. ", 42, 54 28 120 20, tab 1
  text "", 43, 0 38 00 8, tab 1
  tab "ÀÚ±â´Ð", 2
  box "È£Ãâ¼³Á¤", 6, 10 17 130 73, tab 2
  text "¹ÝÀÀÇÒ ´Ü¾î", 8, 14 27 36 8, tab 2
  edit "", 10, 14 37 120 10, tab 2 read
  text "Ãâ·ÂÇÒ ¸»", 9, 14 57 36 8, tab 2
  edit "", 12, 14 67 120 10, tab 2 autohs set %light1
  check "¸Þ¸ðÃâ·Â", 7,145 20 33 8, tab 2
  button "»ç¿îµå ¼³Á¤", 44, 145 36 37 12, tab 2
  tab "È£Ãâ2", 3
  box "È£Ãâ¼³Á¤", 13, 10 17 130 73, tab 3
  text "¹ÝÀÀÇÒ ´Ü¾î", 17, 14 27 36 8, tab 3
  edit "", 18, 14 37 120 10, tab 3 autohs set %high2
  text "Ãâ·ÂÇÒ ¸»", 19, 14 57 36 8, tab 3
  edit "", 20, 14 67 120 10, tab 3 autohs set %light2
  check "¸Þ¸ðÃâ·Â", 33, 145 20 33 8, tab 3
  button "»ç¿îµå ¼³Á¤", 45, 145 36 37 12, tab 3
  tab "È£Ãâ3", 4
  box "È£Ãâ¼³Á¤", 14, 10 17 130 73, tab 4
  text "¹ÝÀÀÇÒ ´Ü¾î", 21, 14 27 36 8, tab 4
  edit "", 22, 14 37 120 10, tab 4 autohs set %high3
  text "Ãâ·ÂÇÒ ¸»", 23, 14 57 36 8, tab 4
  edit "", 24, 14 67 120 10, tab 4 autohs set %light3
  check "¸Þ¸ðÃâ·Â", 34, 145 20 33 8, tab 4
  button "»ç¿îµå ¼³Á¤", 46, 145 36 37 12, tab 4
  tab "È£Ãâ4", 5
  box "È£Ãâ¼³Á¤", 15, 10 17 130 73, tab 5
  text "¹ÝÀÀÇÒ ´Ü¾î", 25, 14 27 36 8, tab 5
  edit "", 26, 14 37 120 10, tab 5 autohs set %high4
  text "Ãâ·ÂÇÒ ¸»", 27, 14 57 36 8, tab 5
  edit "", 28, 14 67 120 10, tab 5 autohs set %light4
  check "¸Þ¸ðÃâ·Â", 35, 145 20 33 8, tab 5
  button "»ç¿îµå ¼³Á¤", 47, 145 36 37 12, tab 5
  tab "È£Ãâ5", 11
  box "È£Ãâ¼³Á¤", 16, 10 17 130 73, tab 11
  text "¹ÝÀÀÇÒ ´Ü¾î", 29, 14 27 36 8, tab 11
  edit "", 30, 14 37 120 10, tab 11 autohs set %high5
  text "Ãâ·ÂÇÒ ¸»", 31, 14 57 36 8, tab 11
  edit "", 32, 14 67 120 10, tab 11 autohs set %light5
  check "¸Þ¸ðÃâ·Â", 36, 145 20 33 8, tab 11
  button "»ç¿îµå ¼³Á¤", 48, 145 36 37 12, tab 11
  button "´Ý    ±â", 55, 145 70 37 12, ok 
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
    if (%switch == ÄÑÁü) { did -c highlight 38 }
    if (%switch == $null) { did -c highlight 39 }
    if (%memomsg1 == ÄÑÁü) { did -c highlight 7 }
    if (%memomsg1 == $null) { did -u highlight 7 }
    if (%memomsg2 == ÄÑÁü) { did -c highlight 33 }
    if (%memomsg2 == $null) { did -u highlight 33 }
    if (%memomsg3 == ÄÑÁü) { did -c highlight 34 }
    if (%memomsg3 == $null) { did -u highlight 34 }
    if (%memomsg4 == ÄÑÁü) { did -c highlight 35 }
    if (%memomsg4 == $null) { did -u highlight 35 }
    if (%memomsg5 == ÄÑÁü) { did -c highlight 36 }
    if (%memomsg5 == $null) { did -u highlight 36 }
  }
  if ( $devent == sclick ) {
    if ( $did == 38 ) { set %switch ÄÑÁü 
      halt
    }
    if ( $did == 39 ) { unset %switch
      halt
    }
    if ($did == 7) { 
      if (%memomsg1 == $null) { set %memomsg1 ÄÑÁü } 
      else { unset %memomsg1 }
      halt
    }
    if ($did == 33) { 
      if (%memomsg2 == $null) { set %memomsg2 ÄÑÁü } 
      else { unset %memomsg2 }
      halt
    }
    if ($did == 34) { 
      if (%memomsg3 == $null) { set %memomsg3 ÄÑÁü } 
      else { unset %memomsg3 }
      halt
    }
    if ($did == 35) { 
      if (%memomsg4 == $null) { set %memomsg4 ÄÑÁü } 
      else { unset %memomsg4 }
      halt
    }
    if ($did == 36) { 
      if (%memomsg5 == $null) { set %memomsg5 ÄÑÁü } 
      else { unset %memomsg5 }
      halt
    }
    if ( $did == 44 ) { set %hlsound1 $sfile($mircdirSOUNDS\,È£Ãâ½Ã ½ÇÇàÇÒ »ç¿îµå¸¦ ¼±ÅÃÇÏ¼¼¿ä,¿­±â)
      halt
    }
    if ( $did == 45 ) { set %hlsound2 $sfile($mircdirSOUNDS\,È£Ãâ½Ã ½ÇÇàÇÒ »ç¿îµå¸¦ ¼±ÅÃÇÏ¼¼¿ä,¿­±â)
      halt
    }
    if ( $did == 46 ) { set %hlsound3 $sfile($mircdirSOUNDS\,È£Ãâ½Ã ½ÇÇàÇÒ »ç¿îµå¸¦ ¼±ÅÃÇÏ¼¼¿ä,¿­±â)
      halt
    }
    if ( $did == 47 ) { set %hlsound4 $sfile($mircdirSOUNDS\,È£Ãâ½Ã ½ÇÇàÇÒ »ç¿îµå¸¦ ¼±ÅÃÇÏ¼¼¿ä,¿­±â)
      halt
    }
    if ( $did == 48 ) { set %hlsound5 $sfile($mircdirSOUNDS\,È£Ãâ½Ã ½ÇÇàÇÒ »ç¿îµå¸¦ ¼±ÅÃÇÏ¼¼¿ä,¿­±â)
      halt
    }
    if ( $did == 37 ) { unset %hlsound* | unset %high* | unset %light* | unset %memomsg* | unset %switch | did -ra highlight 10 $me | did -ra highlight 18 %high2 | did -ra highlight 22 %high3 | did -ra highlight 26 %high4 | did -ra highlight 30 %high5 | did -ra highlight 12 %light1 | did -ra highlight 20 %light2 | did -ra highlight 24 %light3 | did -ra highlight 28 %light4 | did -ra highlight 32 %light5 | did -u highlight 7 | did -u highlight 33 | did -u highlight 34 | did -u highlight 35 | did -u highlight 36 | did -u highlight 38 | did -c highlight 39 
      halt
    }
  }
}
on *:input:#: {
  if ( $1- == !È£Ãâ ) {
    say $1
    echo -a 14»ç¿ë¹ýÀº 12!»ç¿ë¹ý 14ÇÏ½Ã¸é ³ª¿É´Ï´Ù.
    msg $chan 14Dialog 7Loading ...14 £Û 3È£Ãâ&ÀÚµ¿¹ÝÀÀ Controller14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
    dialog -ma highlight highlight
    halt
  }
}

on *:text:*:#: { 
  if ( $me isin $1- ) {
    if ( %switch != ÄÑÁü ) return 
    if ( %memomsg1 == $null ) {
      msg $chan %light1 
    }
    if ( %memomsg1 == ÄÑÁü ) {
      msg $chan %light1 0,8/0,7/0,4/14 ¸Þ¸ð : %memo 0,4/0,7/0,8/
    }
    if ( %hlsound1 == $null ) return {
      splay %hlsound1
      echo -a 1-4¾Ë¸²1-7 $chan 1¿¡¼­14 $nick 1´ÔÀÇ È£Ãâ.
    }
  }
  else if ( %high2 isin $1- ) {
    if ( %switch != ÄÑÁü ) return
    if ( %high2 == $null ) return 
    if ( %memomsg2 == $null ) {
      msg $chan %light2 
    }
    if ( %memomsg2 == ÄÑÁü ) {
      msg $chan %light2 0,8/0,7/0,4/14 ¸Þ¸ð : %memo 0,4/0,7/0,8/
    }
    if ( %hlsound2 == $null ) return {
      splay %hlsound2
      echo -a 1-4¾Ë¸²1-7 $chan 1¿¡¼­14 $nick 1´ÔÀÇ È£Ãâ.
    }
  }
  else if ( %high3 isin $1- ) {
    if ( %switch != ÄÑÁü ) return
    if ( %high3 == $null ) return 
    if ( %memomsg3 == $null ) {
      msg $chan %light3 
    }
    if ( %memomsg3 == ÄÑÁü ) {
      msg $chan %light3 0,8/0,7/0,4/14 ¸Þ¸ð : %memo 0,4/0,7/0,8/
    }
    if ( %hlsound3 == $null ) return {
      splay %hlsound3
      echo -a 1-4¾Ë¸²1-7 $chan 1¿¡¼­14 $nick 1´ÔÀÇ È£Ãâ.
    }
  }
  else if ( %high4 isin $1- ) {
    if ( %switch != ÄÑÁü ) return
    if ( %high4 == $null ) return 
    if ( %memomsg4 == $null ) {
      msg $chan %light4 
    }
    if ( %memomsg4 == ÄÑÁü ) {
      msg $chan %light4 0,8/0,7/0,4/14 ¸Þ¸ð : %memo 0,4/0,7/0,8/
    }
    if ( %hlsound4 == $null ) return {
      splay %hlsound4
      echo -a 1-4¾Ë¸²1-7 $chan 1¿¡¼­14 $nick 1´ÔÀÇ È£Ãâ.
    }
  }
  else if ( %high5 isin $1- ) {
    if ( %switch != ÄÑÁü ) return
    if ( %high5 == $null ) return 
    if ( %memomsg5 == $null ) {
      msg $chan %light5 
    }
    if ( %memomsg5 == ÄÑÁü ) {
      msg $chan %light5 0,8/0,7/0,4/14 ¸Þ¸ð : %memo 0,4/0,7/0,8/
    }
    if ( %hlsound5 == $null ) return {
      splay %hlsound5
      echo -a 1-4¾Ë¸²1-7 $chan 1¿¡¼­14 $nick 1´ÔÀÇ È£Ãâ.
    }
  }
}
