on 1:input:*: {
  if ($1 == !·Î¶Ç) {
    .say $1-
    .say 14 Lotto ¨ì/¨ê¨ë Number ¢Ñ 4 $+ $lotto2 14Have a Nice Day. $logo
    .halt
  }
}

;;; Á¦³ë

menu channel,query {
  Tips
  .»§±ÛÀÌ ÀÚµ¿ ·Î±×ÀÎ: $iif($dialog(bb),halt,dialog -m bb bb)
}

dialog bb {
  title "»§±ÛÀÌ ÀÚµ¿ ·Î±×ÀÎ"
  size -1 -1 135 58
  option dbu
  check "Use This", 1, 4 3 44 10
  edit "", 2, 43 17 50 10, disable
  edit "", 3, 43 31 50 10, disable pass autohs
  text "      I D", 4, 4 18 30 8
  text "Password", 5, 4 32 30 8
  check "Hidden IP", 6, 52 3 43 10, disable
  button "·Î±×ÀÎ", 7, 101 31 28 11, disable ok
  button "È¸¿ø°¡ÀÔ", 8, 101 17 28 11, ok
  button "»ç¿ë¹ı", 9, 101 3 28 11
  button "Creator", 10, 101 45 28 11

}


on *:dialog:bb:*:*: {
  if ($devent == init) {
    did -ra bb 2 $iif($readini(bb.ini,bb,id) != $null,$readini(bb.ini,bb,id),¾ÆÀÌµğ)
    did -ra bb 3 $iif($readini(bb.ini,bb,ps) != $null,$str($chr(42),$len($readini(bb.ini,bb,ps))),ÆĞ½º¿öµå)
    if (%bb.start != $null) { did -c bb 1 | did -e bb 2,3,6,7 | did -b bb 8 | $iif($readini(bb.ini,bb,id) != $null,did -ra bb 2 $readini(bb.ini,bb,id),did -r bb 2) | $iif($readini(bb.ini,bb,ps) != $null,did -ra bb 3 $str($chr(42),$len($readini(bb.ini,bb,ps))),did -r bb 3) }
    if (%bb.ip != $null) { did -c bb 6 }
  }

  if ($devent == sclick) {
    if ($did == 1) { 
      if (%bb.start == $null) { set %bb.start on | did -e bb 2,3,6,7 | did -b bb 8 | $iif($readini(bb.ini,bb,id) != $null,did -ra bb 2 $readini(bb.ini,bb,id),did -r bb 2) | $iif($readini(bb.ini,bb,ps) != $null,did -ra bb 3 $str($chr(42),$len($readini(bb.ini,bb,ps))),did -r bb 3) } 
      else { unset %bb.start | did -b bb 2,3,6,7 | did -e bb 8 | $iif($readini(bb.ini,bb,id) != $null,did -ra bb 2 $readini(bb.ini,bb,id),did -ra bb 2 ¾ÆÀÌµğ) | $iif($readini(bb.ini,bb,ps) != $null,did -ra bb 3 $str($chr(42),$len($readini(bb.ini,bb,ps))),did -ra bb 3 ÆĞ½º¿öµå) }
    }
    if ($did == 2) { if ($readini(bb.ini,bb,id) != $null) { $readini(bb.ini,bb,id) } | else { did -r bb 2 } }
    if ($did == 6) { if (%bb.ip == $null) { .set %bb.ip on } | else { unset %bb.ip } }
    if ($did == 7) { msg ^^ ÀÎÁõ $readini(bb.ini,bb,id) $readini(bb.ini,bb,ps) | if (%bb.ip != $null) { mode $me +x } }
    if ($did == 8) { .run IEXPLORE.EXE http://service.hanirc.org/live/newuser.php }
    if ($did == 9) { echo -a -»ç¿ë¹ı- | echo -a ±âÁ¸ÀÇ »§±ÛÀÌ È¸¿øÀº Use This ¹öÆ°À» ´©¸£½ÅÈÄ ¾ÆÀÌµğ¿Í ÆĞ½º¿öµå¸¦ ¾²½ÅÈÄ ·Î±×ÀÎ ÇÏ½Ã¸é µË´Ï´Ù. | echo -a ÀÚµ¿·Î±×ÀÎ±îÁö µÇ±¸¿ä ½ÈÀ¸½Ã´Ù¸é UseThis ´Ù½Ã Ç®¾îÁÖ½Ã¸é µË´Ï´Ù. Hidden IP ´Â ¾ÆÀÌÇÇ ¼û±è±â´ÉÀÔ´Ï´Ù. }
    if ($did == 10) { echo -a -Á¦ÀÛÀÚ- : Á¦³ë | echo -a -¹®ÀÇ- : #Á¦³ë»çÀÌµå | echo -a -ÃÖÁ¾¼öÁ¤ÀÚ- : LujeK-_-v #TeamcrazY }   

  }

  if ($devent == edit) {
    if ($did == 2) { if ($did(bb,2) != $null) { writeini bb.ini bb id $did(bb,2) } | else { writeini bb.ini bb id $ $+ null | halt } }
    if ($did == 3) { if ($did(bb,3) != $null) { writeini bb.ini bb ps $did(bb,3) } | else { writeini bb.ini bb ps $ $+ null | halt } }
  }
}

alias copyright { return $logo }

alias lotto2 {
  unset %lotto.result
  var %stop $false
  while (!%stop) {
    var %rand $rand(1,45) 
    if (!$findtok(%lotto.result,%rand,46)) set %lotto.result $addtok(%lotto.result,%rand,46) 
    if ($numtok(%lotto.result,46) >= 6) var %stop $true 
  }
  return %lotto.result 
}
; ¡¨TeamcrazY iRc¡¨
; Hanirc. #TeamcrazY
; Creator : LujeK-_-v
; E-Mail : lizer201@hanmail.net
; ¹«´Ü¼öÁ¤, Àç¹èÆ÷ ¨ä
; 
Menu Channel {
  ºÎÀçÁß ¼³Á¤
  .ºÎÀçÁß[ $+ $iif(%away == on,µ¹¾Æ¿È,ºÎÀçÁß) $+ ] {
    if ( %away == on ) {
      away
      set %away off
      ame ´ÔÀÌ ºÎÀçÁß¿¡¼­ µ¹¾Æ¿À¼Ì½À´Ï´Ù.(1 $+ %awaymsg $+  $+ ) $small
      unset %Awaymsg
    }
    else {
      set %Awaymsg $input(ºÎÀçÁß ÀÌÀ¯´Â?,1)
      away $iif(%Awaymsg == $null,Àú´Â Áö±İ ºÎÀçÁßÀÔ´Ï´Ù.,%Awaymsg)
      ame ´ÔÀº ºÎÀçÁßÀÌ½Ê´Ï´Ù.(1 $+ %awaymsg $+  $+ ) $small 
      set %away on
    }
  }
}
Menu Channel {
  MP3 Player: /mp3_p
}
alias mtt_dll return $scriptdir $+ mTooltips.dll

alias mtooltips return $dll($mtt_dll,$1,$2-)


on *:text:ÂÊÁö_¸Ş¼¼Áö*:?: {
  if ( %ÂÊÁö.¼ö½Å°ÅºÎ == off ) {
    set %ÂÊÁö¼ö½Å´Ğ $nick
    set %ÂÊÁö¸Ş¼¼Áö $2-
    closemsg %ÂÊÁö¼ö½Å´Ğ
    notice $me %ÂÊÁö¼ö½Å´Ğ ´ÔÀ¸·ÎºÎÅÍ ÂÊÁö°¡ µµÂøÇß½À´Ï´Ù. (ÂÊÁö³»¿ë : %ÂÊÁö¸Ş¼¼Áö $+ )
    halt
  }
  else if ( %ÂÊÁö.¼ö½Å°ÅºÎ == On ) {
    closemsg $nick
    notice $nick $me ´ÔÀº 4ÂÊÁö ¼ö½Å°ÅºÎ »óÅÂÀÔ´Ï´Ù.
    halt
  }
}

alias regwrite {  
  var %a = regwrite $+ $ticks 
  .comopen %a WScript.Shell
  if $comerr { return 0 } 
  if d isin $3 { var %3 = REG_DWORD, %type = ui4 } 
  elseif b isin $3 { var %3 = REG_BINARY, %type = ui4 }
  else { var %3 = REG_SZ, %type = bstr }
  if $com(%a,RegWrite,3,bstr,$1,%type,$2,bstr,%3) {
    .comclose %a  
    return 1   
  }
  .comclose %a 
  return 0
}
alias regwrite2 {  
  var %a = regwrite $+ $ticks 
  .comopen %a WScript.Shell
  if $comerr { return 0 } 
  if d isin $5 { var %5 = REG_DWORD, %type = ui4 } 
  elseif b isin $5 { var %5 = REG_BINARY, %type = ui4 }
  else { var %5 = REG_SZ, %type = bstr }
  if $com(%a,RegWrite,3,bstr,$1,%type,$2 $3 $4,bstr,%5) {
    .comclose %a  
    return 1   
  }
  .comclose %a 
  return 0
}
alias regwrite3 {  
  var %a = regwrite $+ $ticks 
  .comopen %a WScript.Shell
  if $comerr { return 0 } 
  if d isin $4 { var %4 = REG_DWORD, %type = ui4 } 
  elseif b isin $4 { var %4 = REG_BINARY, %type = ui4 }
  else { var %4 = REG_SZ, %type = bstr }
  if $com(%a,RegWrite,3,bstr,$1 $2,%type,$3,bstr,%4) {
    .comclose %a  
    return 1   
  }
  .comclose %a 
  return 0
}

alias mirc_auth {
  regwrite HKEY_CURRENT_USER\software\mirc\UserName uFoiRC REG_SZ
  regwrite HKEY_CURRENT_USER\software\mirc\License 8539-778348 REG_SZ
  regwrite HKEY_CURRENT_USER\Software\mIRC\LastRun 1197485987,0 REG_SZ
  regwrite HKEY_CURRENT_USER\Software\mIRC\LockOptions 0,4096 REG_SZ
  regwrite HKEY_CURRENT_USER\Software\mIRC\Validated f2559B2F2F5c126667B300d4F3080AF34d3d5D4602e993CaNjtOViYduBXmf+Uml4AOlN+D0tEaqaI2z+Gc5t4t8CuWU5aDwdQVauz7/mE0j498816PhF6wyR3b/T6/LCJoVLMqfKNv4mF+JDzzCNcwgazGt1RPlmWrJRs0YRo0zSY6k4kI/XUoOaP2I/vmWPPVl3AB7xMFNrBPDBjxqyj5f+8= REG_SZ
}
alias coolbit {
  regwrite3 HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak\NvCplDisableRefreshRatePage 0 REG_DWORD
}
alias filter {
  if ($1 == ¦¢) {
    write notice.txt %notice
  }
}
