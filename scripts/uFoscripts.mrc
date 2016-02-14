alias -l GetLibrary { return SpeedCheck.dll }
;; ip nick
#trace off
raw 352:*: { 
  inc %trace.counter
  if (%trace.counter > 3) { msg $active %logo °Ë»öµÈ °á°ú°¡ 3°³ ÀÌ»óÀÔ´Ï´Ù. Á»´õ ¹üÀ§¸¦ ¾ÐÃàÇÏ¿© °Ë»öÇØÁÖ¼¼¿ä. | unset %trace | .disable #trace }
  else { msg $active %logo 0,4´Ð4³×ÀÓ[ $6 ] 0,3¾Æ3ÀÌÇÇ[ $4 ] 0,12Ã¤12³Î[ $2 ] 0,14»ç14¿ëÀÚ¸í[ $3 ] }
  halt
}
raw 315:*: { .disable #trace  | halt }
#trace end

#trace2 off
raw 352:*: { 
  echo $active %logo 0,4´Ð4³×ÀÓ[ $6 ] 0,3¾Æ3ÀÌÇÇ[ $4 ] 0,12Ã¤12³Î[ $2 ] 0,14»ç14¿ëÀÚ¸í[ $3 ]
  halt
}
raw 315:*: { .disable #trace2  | halt }
#trace2 end

raw 205:*: { 
  msg $active %logo $4
  halt 
}
;; Ã¦¼·
alias Chanserv_info { 
  sockclose Chanserv_info
  sockopen Chanserv_info pink.the-7.net 80 
}

;;--sockÀÔ·Âpart--;;

On 1:sockopen:Chanserv_info:sockwrite -nt Chanserv_info GET http://hanirc-chanstat.the-7.net/csqual.cgi?channel= $+ %Chanserv_chan 

;;--Web_temp ÃßÃâpart--;;

On *:sockread:Chanserv_info: { 
  sockread %Chanserv_temp
  if ( Á¸ÀçÇÏÁö isin %Chanserv_temp ) {
    set %Chanserv_error $chr(91) 4- Error - $chr(93) $chr(35) $+ %Chanserv_chan Ã¤³Î¿¡ ´ëÇÑ Á¤º¸°¡ Á¸ÀçÇÏÁö ¾Ê½À´Ï´Ù.
    halt
  }
  else if ( ºñÀ²</TD><TD> isin %Chanserv_temp ) {
    set %Chanserv_msg1 7ÀÎ¿ø 10¸í ³Ñ´Â ºñÀ² ¢¹ $remove(%Chanserv_temp,<TR><TD>10¸í ³Ñ´Â ºñÀ²</TD><TD>,</TD></TR>) 
    halt
  }
  else if ( ÀÎ¿ø</TD><TD> isin %Chanserv_temp ) {
    set %Chanserv_msg2 7Æò±Õ ÀÎ¿ø ¢¹ $remove(%Chanserv_temp,<TR><TD>Æò±Õ ÀÎ¿ø</TD><TD>,</TD></TR>)
    halt
  }
  else if ( Á¡¼ö</TD><TD> isin %Chanserv_temp ) { 
    set %Chanserv_msg3 7»ç¿ëµµ Á¡¼ö ¢¹ $remove(%Chanserv_temp,<TR><TD>»ç¿ëµµ Á¡¼ö</TD><TD>,</TD></TR>)
    halt
  }
  else if ( ÀÚ°Ý</TD><TD> isin %Chanserv_temp ) { 
    if ( È¸¼öµË´Ï´Ù.</font></TABLE></TD></TR> isin %Chanserv_temp ) {
      set %Chanserv_msg4 7Ã¦¼· ½ÅÃ» ÀÚ°Ý ¢¹ ½ÅÃ» ÇÒ ¼ö ¾ø½À´Ï´Ù.Chanserv °¡ ÀÖ´õ¶óµµ È¸¼öµË´Ï´Ù.
      halt
    }
    else if ( ½ÅÃ»ÇÏ½Ã±â isin %Chanserv_temp ) {
      set %Chanserv_msg4 7Ã¦¼· ½ÅÃ» ÀÚ°Ý ¢¹ ½ÅÃ» ÇÒ ¼ö ÀÖ½À´Ï´Ù.¾à°üÀ» ÇÑ¹ø ´õ È®ÀÎÇÏ½Ã°í ½ÅÃ»ÇÏ½Ã±â ¹Ù¶ø´Ï´Ù.
      halt
    }
    else if ( °ø¹é ½Ã°£ isin %Chanserv_temp ) {
      set %Chanserv_msg4 7Ã¦¼· ½ÅÃ» ÀÚ°Ý ¢¹ ½ÅÃ» ÇÒ ¼ö ¾ø½À´Ï´Ù. Ã¤³Î °ø¹é½Ã°£ ÃÊ°úÀÔ´Ï´Ù.
    }
    else if ( »ç¿ëµµ Á¡¼ö isin %Chanserv_temp ) {
      set %Chanserv_msg4 7Ã¦¼· ½ÅÃ» ÀÚ°Ý ¢¹ ½ÅÃ» ÇÒ ¼ö ¾ø½À´Ï´Ù. »ç¿ëµµ Á¡¼ö ¹Ì´ÞÀÔ´Ï´Ù.
    }
  }
} 

;;--sockÃâ·Âpart--;;

on *:sockclose:Chanserv_info: {
  if ( %Chanserv_error != $null ) {
    msg %chanservinfo_chan 10 $+ $chr(35) $+  %Chanserv_chan Ã¤³Î Chanserv ½ÅÃ»ÀÚ°Ý Info... 
    msg %chanservinfo_chan %Chanserv_error
    msg %chanservinfo_chan --- Copyright(C) HanIRC Operator Group, 2004. --- 
    unset %Chanserv_*
    halt
  }
  else if ( %Chanserv_error == $null ) {
    msg %chanservinfo_chan 10 $+ $chr(35) $+ %Chanserv_chan Ã¤³Î Chanserv ½ÅÃ»ÀÚ°Ý Info...
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
  if ( $1 == !Ã¤³Î ) {
    /say $1
    /say ¿É 2 $opnick(#,0) ¸í µð¿É : 4 $nopnick(#,0) ¸í º¸ÀÌ½º : 6 $vnick(#,0) ¸í µðº¸ÀÌ½º : 10 $nvnick(#,0) ¸í ÃÑ 12 $nick(#,0,a) ¸í ÀÔ´Ï´Ù.
    halt
  }
  if ($1- == !¾ÆÇÇ) {
    /ip
  halt }
  if ($1- == !ÀÔ½Ç¼ö) {
    /say $1
    /say 15[14 $+ $me $+ 15]12 ´Ô²²¼­ ÀÔ½ÇÇÑ Ã¤³ÎÀÇ ¼ö´Â 15[14 $+ $chan(0) $+ 15]12 °³ ÀÔ´Ï´Ù.  $logo
  halt }

  if (($1 == !Á¤º¸) && ($2-)) {
    /say !Á¤º¸ $2-
    /whois $2-
  halt } 

  if ($1 == !¼Ò½º) {
    if (%steamdir == $null) {
      /say $1-
      /say ½ºÆÀÀÇ °æ·Î°¡ ¼³Á¤µÇÁö ¾Ê¾Ò½À´Ï´Ù. '!¼³Á¤'À» ÇÏ¼Å¼­ ½ºÆÀÀÇ °æ·Î¸¦ ¼³Á¤ÇØÁÖ½Ã±â ¹Ù¶ø´Ï´Ù. 
      halt
    }
    else {
      /say $1-
      /say 12 $me 1 is 3 $2-  1connecting...
      /run %SteamDIR -applaunch 240 -console %³ëÆ÷½º +connect $remove$+ $2-
    halt }
  }
  if ($1 == !ÇÏÇÁ) {
    if (%steamdir == $null) {
      /say $1-
      /say ½ºÆÀÀÇ °æ·Î°¡ ¼³Á¤µÇÁö ¾Ê¾Ò½À´Ï´Ù. '!¼³Á¤'À» ÇÏ¼Å¼­ ½ºÆÀÀÇ °æ·Î¸¦ ¼³Á¤ÇØÁÖ½Ã±â ¹Ù¶ø´Ï´Ù. 
      halt
    }
    else {
      /say $1-
      /say 12 $me 1 is 3 $2-  1connecting...
      /run %SteamDIR -applaunch 70 -console %³ëÆ÷½º +connect $remove$+ $2-
    halt }
  }
  if (($1 == !¹öÀü) && ($2-)) {
    /say !¹öÀü $2-
    /version $2-
  halt }
  IF ($1- == !Æ®·¹ÀÌ) {
    /say $1
    /amsg 14 Ã¢À» Æ®·¹ÀÌ»óÅÂ·Î ÀüÈ¯ÇÕ´Ï´Ù. $logo
    /showmirc -t
  halt }
  IF ($1- == !ÄÄÅÍ) {
    /say $1
    /SystemInfo
  halt }
  IF ($1- == !À½¾Ç) {
    /say $1
    /say 14Dialog 7Loading1 ...14 £Û 3Cool Mp3 Player14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
    /mp3_p
  halt }
  IF ($1- == !¹ÂÁ÷) {
    /say $1
    /say 14Dialog 7Loading1 ...14 £Û 3Cool Mp3 Player14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
    /mp3_p
  halt }
  if ($1 == !½ºÆÀ) {
    if (%steamdir == $null) {
      /say $1-
      /say ½ºÆÀÀÇ °æ·Î°¡ ¼³Á¤µÇÁö ¾Ê¾Ò½À´Ï´Ù. '!¼³Á¤'À» ÇÏ¼Å¼­ ½ºÆÀÀÇ °æ·Î¸¦ ¼³Á¤ÇØÁÖ½Ã±â ¹Ù¶ø´Ï´Ù. 
      /run http://cdn.steampowered.com/download/SteamInstall.msi
      halt
    }
    elseif (%steamdir != $2-) {
      .say $1-
      .say 14Program 7Loading1 ...14 £Û 3Steam14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
      .run %steamdir
      halt
    }   
  }
  if ($1 == !SXE) {
    if (%sxedir == $null) {
      /say $1-
      /say sXe InjectedÀÇ °æ·Î°¡ ¼³Á¤µÇÁö ¾Ê¾Ò½À´Ï´Ù. '!¼³Á¤'À» ÇÏ¼Å¼­ sXeÀÇ °æ·Î¸¦ ¼³Á¤ÇØÁÖ½Ã±â ¹Ù¶ø´Ï´Ù. 
      /run http://www.sxe-injected.com/downloads
      halt
    }
    elseif (%sxedir != $2-) {
      .say $1-
      .say 14Program 7Loading ...14 £Û 3sXe Injected14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
      .run %sxedir 
      halt
    }
  }
  if ($1 == !hl || $1 == !hltv) {
    if (%hltvdir == $null) {
      /say $1-
      /say HLTVÀÇ °æ·Î°¡ ¼³Á¤µÇÁö ¾Ê¾Ò½À´Ï´Ù. '!¼³Á¤'À» ÇÏ¼Å¼­ HLTVÀÇ °æ·Î¸¦ ¼³Á¤ÇØÁÖ½Ã±â ¹Ù¶ø´Ï´Ù. 
      halt
    }
    elseif (%hltvdir != $2-) {
      .say $1-
      .say 14Program 7Loading ...14 £Û 3HLTV14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
      .run -p %hltvdir
      .halt
    }
  }
  if ($1- == !Ä«¿Â) {
    if (%csodir == $null) {
      /say $1-
      /say Ä«½º¿Â¶óÀÎÀÇ °æ·Î°¡ ¼³Á¤µÇÁö ¾Ê¾Ò½À´Ï´Ù. '!¼³Á¤'À» ÇÏ¼Å¼­ °æ·Î¸¦ ¼³Á¤ÇØÁÖ½Ã±â ¹Ù¶ø´Ï´Ù. 
      halt
    }
    elseif (%csodir != $2-) {
      .say $1-
      .say 14Program 7Loading1 ...14 £Û 3Counter Strike : Online14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
      .run -p %csodir
      if ( %ingametray == 1 ) {
        /showmirc -n
      }
      halt
    }   
  }
  IF ($1- == !»çÀÌÆ®) {
    /site
  halt } 
  if (($1 == !À¥)) {
    if ($2 == $null ) { .say !À¥ | /run C:\Program Files\Internet Explorer\iexplore.exe | /halt }
    /say !À¥ http:// $+ $remove($2,http://)
    /say 14Web 7Loading ...14 £Û3 http:// $+ $remove($2,http://) 14£Ý¦¡¦¬¦¬¦¬¦¬ $logo
    /run http:// $+ $remove($2,http://)
  halt } 
  if (($1 == !À¥2)) {
    if ($2 == $null ) { .echo $mini !À¥2 µÚ¿¡ À¥ÁÖ¼Ò¸¦ ÀÔ·ÂÇÏ¼¼¿ä. | /halt }
    /say !À¥2 http:// $+ $remove($2,http://)
    /say 14Web 7Loading ...14 £Û3 http:// $+ $remove($2,http://) 14£Ý¦¡¦¬¦¬¦¬¦¬ $logo
    /ircweb http:// $+ $remove($2,http://)
  halt }
  IF ($1- == !½Ã°£) {
    /times
  halt } 
  IF ($1- == !ÁÖ»ç) {
    /jusawe
  halt } 
  IF ($1- == !»ç¿ë¹ý) {
    /say $1
    /say 14Program 7Loading ...14 £Û 3»ç¿ë¼³¸í¼­14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
    /teamcrazyhelp
  halt }
  if ($1- == !Ã») {
    /clearall
    /say $1
    /say 14¸ðµç Ã¢À» Ã»¼ÒÇÕ´Ï´Ù. $logo
  halt }
  if ($1- == !´Ð) {
    /say !´Ð
    /echo ±âº»¼³Á¤À» ¹Ù²Ù½Ã·Á¸é !¼³Á¤ ¿¡¼­ ¸»¸Ó¸®,¸»²¿¸® ¼³Á¤¿¡¼­ ¹Ù²ãÁÖ½Ã¸é µË´Ï´Ù. (´Ù½Ã µ¹¾Æ¿À½Ã·Á¸é !´Ð ÇÑ¹ø´õÇÏ¼¼¿ä)
    /setting.update saytit saytit
  halt }
  if ($1- == !¸Þ) {
    /say !¸Þ
    /memo
  halt }    
  if ($1- == !º»´Ð) {
    /say !º»´Ð
    /nick %nickdefault   
  halt }  
  if ($1- == !Àá¼ö) {
    /say !Àá¼ö
    /nick %nick2nd $+ lÀá¼ö
  halt }
  if ($1- == !¹ä) {
    /say !¹ä
    /nick %nick2nd $+ l½Ä»çÁß
  halt }
  if ($1- == !½ÃÃ¼) {
    /say !½ÃÃ¼
    /nick %nick2nd $+ l½ÃÃ¼
  halt }
  if ($1- == !ÈÞ½Ä) {
    /say !ÈÞ½Ä
    /nick %nick2nd $+ lÈÞ½Ä
  halt }
  if ($1- == !Àá) {
    /say !Àá
    /nick %nick2nd $+ lÄðÄð
  halt }
  if ($1- == !º¿) {
    /say !º¿
    /nick %nick2nd $+ lº¿
  halt }
  if ($1- == !¸ÅÄ¡) {
    /say !¸ÅÄ¡
    /nick %nick2nd $+ l¸ÅÄ¡
  halt }
  if ($1- == !±×¸²ÆÇ) {
    /say $1
    /run mspaint
    /say 14Program 7Loading ...14 £Û 3±×¸²ÆÇ14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
  halt }
  if ($1- == !¸Þ¸ðÀå) {
    /say $1
    /run notepad
    /say 14Program 7Loading ...14 £Û 3¸Þ¸ðÀå14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
  halt }
  if ($1- == !Ã»¼Ò) {
    /say !Ã»¼Ò
    /clear
  halt }
  if ($1- == !µµ¿ò¸») {
    /say !µµ¿ò¸»
    /ufohelp
  halt }   
  if ($1- == !³»¸Þ¸ð) {
    /say !³»¸Þ¸ð
    /say $nick 10 ¸Þ¸ð³»¿ë: 14 %memo
  halt }
  if ($1- == !ÇÒ) {
    /say !ÇÒ
    /do
  halt }
  if ($1- == !¼³Á¤) {
    /say !¼³Á¤
    /config
  halt }
  if ($1- == !Á¾·á) {
    /say !Á¾·á
    if ( $os == xp || $os == Vista ) {
      ./run shutdown -s -t 00
      /exit
      halt
    }
    else {
      /dll Sd.dll WinMenu
    halt }
  }
  if ($1- == !¸®º×) {
    /say !¸®º×
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
  if ($1- == !ÅäÇÈ) {
    /say !ÅäÇÈ
    /say 14 $chan ÅäÇÈ¢Ñ $chan($chan).topic
  halt }
  if ($1 == !ÅäÇÈ°í) {
    /say $1-
    topicgo $chan($chan).topic 
  halt } 
  if ($1 == !½º¼¼°í) {
    /say $1-
    /var %ÅäÇÈ¼­¹ö $chan($chan).topic 
    /run %sxedir
    /say 14RUN :12 sXe InjectedÀ» ½ÇÇàÇÕ´Ï´Ù. $logo  
    /sxego
    /echo 4 25ÃÊ 14¾È¿¡ sXe injected ¸¦ ÃÖ»óÀ§·Î È°¼ºÈ­ ½ÃÄÑÁÖ¼¼¿ä.
    .timerantiflood 1 25 .timersxe off
  halt } 
  if ($1 == !³ë¹Ù°í) {
    /say $1-
    /var %ÅäÇÈ¼­¹ö $chan($chan).topic 
    /say 14Run:12 Novacap14 À» ½ÇÇàÇÕ´Ï´Ù..
    topicgo $chan($chan).topic 
    /run $mircdirutil\Novacap\novacap.exe
    /showmirc -n
  halt }
  if ($1 == !hlÅäÇÈ || $1 == !hlÅäÇÈ°í) {
    /say $1-
    hltopicgo $chan($chan).topic
  halt } 
  if ($1 == !Ã¦¼·)  {
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
  if ( $1 == !ÃßÀû ) {
    if ($2) { unset %trace.counter | .enable #trace | .who $2 }
    else { .say $1- |  msg $active %logo »ç¿ë¹ý : !ÃßÀû °Ë»ö¾î 1(* ¿ÍÀÏµåÄ«µå »ç¿ë°¡´É ex : !ÃßÀû *±æµ¿*) | .halt }
  }
  if ( $1 == !@ÃßÀû ) { .enable #trace2 | .who $2 }
  if ( $1 == !¸®¾ó ) { .trace $2 }
  if ( $1 == !Ã£±â ) {
    msg $active $1-
    echo -a $mini Á»´õ ÀÚ¼¼ÇÑ Á¤º¸¸¦ ¿øÇÏ½Ã¸é 5!ÃßÀû ¾ÆÀÌÇÇ1 ÇÏ¼¼¿ä.
    set %ipnickv On
    who $2
    halt
  }
  if ($1 == !Ã¼Å©)  {
    var %Type
    if ( $2 == ´Ù¿î·Îµå ) {
      %Type = DN
    }
    else if ( $2 == ¾÷·Îµå ) {
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
        /say ÀÎÅÍ³Ý ´Ù¿î·Îµå ¼Óµµ: %bps ( 4 %bts )
      }
      %temp = $gettok(%Speed,2,$asc(|))
      if ( %temp != - ) {
        %bps = $gettok(%temp,1,$asc(!))
        %bts = $gettok(%temp,2,$asc(!))
        /say ÀÎÅÍ³Ý ¾÷·Îµå ¼Óµµ: %bps ( 12 %bts )
      }
    }
    else if ( %bResult == S_FAIL ) {
      /echo -a ÀÎÅÍ³Ý ¼ÓµµÃøÁ¤ ¿À·ù: $Dll($GetLibrary,GetError,)
    }
    halt
  }
  if ($1 == !°Ë»ö) {
    .say $1-
    if ( $2 == $null ) {
      .say 14Program 7Loading ...14 £Û 3°Ë»öÅø¹Ù14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
      .mirc_tool_start
      halt
    }
    else {
      .say 14Program 7Loading ...14 £Û 3³×ÀÌ¹ö " $+ $2- $+ " °Ë»ö14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
      run http://search.naver.com/search.naver?where=3&oldquery=&restrict=0&field=0&host=&dir=&homepage=0&display=10&start=1&query= $+ $2- $+ 
      halt
    }
  }
  if ($1 == !³×ÀÌ¹ö) {
    say $1-
    if ($2 == $null) {
      run http://www.naver.com
      .say 14Program 7Loading ...14 £Û 3www.naver.com14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
    }
    else {
      .say 14Program 7Loading ...14 £Û 3³×ÀÌ¹ö " $+ $2- $+ " °Ë»ö14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
      run http://search.naver.com/search.naver?where=3&oldquery=&restrict=0&field=0&host=&dir=&homepage=0&display=10&start=1&query= $+ $2- $+
    }
    halt
  }
  if ($1 == !±¸±Û) {
    say $1-
    if ($2 == $null) {
      run http://www.google.com
      .say 14Program 7Loading ...14 £Û 3www.google.com14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
    }
    else {
      .say 14Program 7Loading ...14 £Û 3±¸±Û " $+ $2- $+ " °Ë»ö14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
      run "http://www.google.co.kr/search?q= $+ $2- $+ "
    }
    halt
  }
  if ($1 == !´Ù¿î) {
    .say $1-
    .say 14Dialog 7Loading ...14 £Û 3Downloader14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
    downloader_start
    halt
  }
  if ($1 == !ÀÎÁõ) {
    .say $1-
    .say 14Reg 7Write1 ...14 £Û 3mIRC µî·ÏÀÎÁõ14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
    .run $mircdirÀÎÁõ.reg
    halt
  }
  if ($1 == !Àç»ýºóµµ) {
    .say $1-
    .say 14Reg 7Write1 ...14 £Û 3Geforce Àç»ýºóµµ14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
    coolbit
    halt
  }
  if ($1 == !ÀÚµ¿Á¶ÀÎ) {
    if ($2 == $null) {
      say $1-
      if ($chan($active).key != $null) {
        write auto_join_p.txt /join $chan $chan($active).key
        msg $active $logo 4 $chan Ã¤³ÎÀ» Å°¿öµå4 $chan($active).key (À¸)·Î ÀÚµ¿Á¶ÀÎ¿¡ Ãß°¡Çß½À´Ï´Ù.
      }
      else {
        var %auto_join_chan = $read(auto_join.txt,1)
        write -c auto_join.txt
        write auto_join.txt %auto_join_chan $chan
        write auto_join_list.txt $chan
        msg $active $logo 4 $chan Ã¤³ÎÀ» ÀÚµ¿Á¶ÀÎ¿¡ Ãß°¡Çß½À´Ï´Ù.
        echo -a $mini 4ºñ¹ø(Å°¿öµå)¹æ ÀÚµ¿Á¶ÀÎÀº ¿ÉÀÌ ÀÖÀ» ½Ã¿¡¸¸ °¡´ÉÇÕ´Ï´Ù. 
        echo -a $mini 4¸¸¾à Áö±Ý ºñ¹ø¹æÀ» ÀÚµ¿Á¶ÀÎÇß´Ù¸é !ÀÚµ¿Á¶ÀÎ »èÁ¦¸¦ ÇÏ½ÅÈÄ ¿ÉÀ» ¹ÞÀ¸½Ã°í !ÀÚµ¿Á¶ÀÎ ÇÏ½Ã±â ¹Ù¶ø´Ï´Ù.
      }
    }
    if ($2 == »èÁ¦) {
      say $1-
      if ($chan($active).key != $null) {
        write -dw* $+ $active $+ * auto_join_p.txt
        msg $active $logo 4 $chan Ã¤³ÎÀ» ÀÚµ¿Á¶ÀÎ¿¡¼­ »èÁ¦Çß½À´Ï´Ù.
      }
      else {
        var %auto_join_im = $read(auto_join.txt,1)
        var %auto_join_chan = $remove(%auto_join_im,$active)
        write -c auto_join.txt
        write auto_join.txt %auto_join_chan
        write -dw* $+ $active auto_join_list.txt
        msg $active $logo 4 $chan Ã¤³ÎÀ» ÀÚµ¿Á¶ÀÎ¿¡¼­ »èÁ¦Çß½À´Ï´Ù.
      }
    }
    if ($2 == ¸ðµÎ»èÁ¦) {
      say $1-
      write -c auto_join.txt
      write -c auto_join_p.txt
      write -c auto_join_list.txt
      msg $active $logo 4 ¸ðµçÃ¤³ÎÀ» ÀÚµ¿Á¶ÀÎ¿¡¼­ »èÁ¦Çß½À´Ï´Ù.
    }
    halt 
  }
  if ($1 == !Á¶ÀÎ¼³Á¤) {
    say $1
    say 14Dialog 7Loading ...14 £Û 3ÀÚµ¿Á¶ÀÎ Controller14 £Ý¦¡¦¬¦¬¦¬¦¬ $logo
    /dialog -ma Autojoin_Controler Autojoin_Controler
    halt
  }
}
;; !Ã£±â
alias °Ë»ö { who $1 }
alias who {
  if ( $active != Status Window ) {
    unset %ipnick
    who $1
  }
}

raw 315:*: {
  if ( %ipnickv == on ) {
    msg $active 5°Ë»ö°á°ú: $+ $iif(%ipnick == $null,°Ë»öÇÑ »ç¿ëÀÚ°¡ ¾ø½À´Ï´Ù.,%ipnick)
    unset %ipnick %ipnickv
  }
  else { 
    echo $color(info) -a *** °Ë»ö°á°ú: $+ $iif(%ipnick == $null,°Ë»öÇÑ »ç¿ëÀÚ°¡ ¾ø½À´Ï´Ù.,%ipnick)
    unset %ipnick %ipnickv
  }
  halt
}

raw 352:*: {
  if ( %ipnickv == on ) {
    if ( $len(%ipnick) <= 400 ) { set %ipnick %ipnick $6 }
    else {
      msg $active 5°Ë»ö°á°ú: $+ %ipnick
      unset %ipnick
    }
  }
  else {
    if ( $len(%ipnick) <= 400 ) { set %ipnick %ipnick $6 }
    else {
      echo $color(info) -a *** °Ë»ö°á°ú: $+ %ipnick
      unset %ipnick
    }
  }
  halt
}

raw 416:*: {
  if ( %ipnickv == on ) {
    msg $active 5µ¥ÀÌÅÍ°¡ ³Ê¹« ¸¹½À´Ï´Ù.
    unset %ipnick %ipnickv
  }
  else {
    echo $color(info) -a *** µ¥ÀÌÅÍ°¡ ³Ê¹« ¸¹½À´Ï´Ù.
    unset %ipnick %ipnickv
  }
  halt
}

;; ÅäÇÈ setting

alias st {
  if ($active ischan) {
    dialog $iif($dialog(settopic),-v,-m) settopic settopic
    dialog -t settopic Set $active topic (Manu :D)
    did -ra settopic 5 $chan($active).topic
    if ($me isop $active) || ($me ishop $active) || (t !isincs $gettok($chan($chan).mode,1,32)) { did -e settopic 7 }
    if ($topiclen isnum) { did -ra settopic 4 $calc($topiclen - $len($chan($active).topic)) }
    prevtopic
  }
  else { echo $active ÀÌ ½ºÅ©¸³Àº ¿ÀÁ÷ Ã¼³Î¿¡¼­¸¸ °¡´ÉÇÕ´Ï´Ù. :D }
}
on *:rawmode:#:{ if (($me isop $chan) || ($me ishop $chan) || (t !isincs $gettok($chan($chan).mode,1,32))) && ($chan == $gettok($dialog(settopic).title,2,32)) { did -e settopic 7 } }
dialog settopic {
  size -1 -1 249 50
  option dbu
  text ÃÖ´ë ÅäÇÈ ±æÀÌ:,1,3 3 70 9
  text ³²Àº ÅäÇÈ ±ÛÀÚ °¹¼ö:,2,165 3 70 9
  text $topiclen,3,52 3 15 9,right
  text $topiclen,4,220 3 25 9,right
  edit "",5,2 12 245 11,autohs limit 600
  icon 8,2 23 245 13,topic\ttemp.bmp
  button "Ãë¼Ò",6,164 37 40 11,cancel
  button "¼³Á¤ :D",7,207 37 40 11,ok disabled
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

ON *:text:*!¸Þ¸ð:#:/notice $nick 10¸Þ¸ð³»¿ë: 14 %memo
on *:text:*!¹öÀü:#:/notice $nick $logo

;; ÀÚµ¿Á¶ÀÎ ÄÁÆ®·Ñ

dialog Autojoin_Controler {
  title "ÀÚµ¿ Ã¤³Î Á¶ÀÎ ÄÁÆ®·Ñ·¯"
  size -1 -1 132 147
  option dbu
  list 10, 10 15 64 113, size vsbar
  box "Ã¤³Î ¸®½ºÆ®", 1, 4 6 76 128
  button "Ã¤³Î Ãß°¡", 20, 91 21 33 11
  button "Ã¤³Î »èÁ¦", 30, 91 34 33 11
  button "Ã¤³Î Á¶ÀÎ", 40, 91 47 33 11
  button "¸ðµÎ »èÁ¦", 50, 91 60 33 11
  text "Ã¤³Î Á¤º¸", 3, 89 75 29 8
  text "     ¸Þ ´º", 2, 91 11 32 8
  text "ÃÑÀÎ¿ø :", 4, 85 86 25 8
  text "   ¡Ä", 60, 108 86 19 8
  text "¹æÀå¼ö :", 5, 85 95 25 8
  text "   ¡Ä", 70, 108 95 19 8
  text "   ¡Ä", 80, 108 104 19 8
  text "º¸ÀÌ½º :", 6, 85 104 25 8
  text "ÀÏ¹ÝÀÎ :", 7, 85 113 25 8
  text "   ¡Ä", 90, 108 113 19 8
  button "Ãë¼Ò", 3000, 0 0 0 0, cancel
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
dialog °æ°íMSG {
  title "°æ°í!"
  size -1 -1 99 42
  option dbu
  text "ÀÌ ¸í·ÉÀ» ¼öÇàÇÏ°Ô µÇ¸é, ÀÚµ¿Á¶ÀÎÀÌ ¼³Á¤µÈ ¸ðµç Ã¤³ÎÀÌ »èÁ¦µË´Ï´Ù. ±×·¡µµ °è¼Ó ÇÏ½Ã°Ú½À´Ï±î?", 1, 5 5 90 18
  button "³×", 2, 4 26 43 12, ok
  button "¾Æ´Ï¿À", 3, 52 26 43 12, cancel
}

on *:dialog:Autojoin_Controler:sclick:10:{ 
  did -ra Autojoin_Controler 60 ¡¡ $+ $nick($did(Autojoin_Controler,10).seltext,0)
  did -ra Autojoin_Controler 70 ¡¡ $+ $opnick($did(Autojoin_Controler,10).seltext,0)
  did -ra Autojoin_Controler 80 ¡¡ $+ $vnick($did(Autojoin_Controler,10).seltext,0)
  did -ra Autojoin_Controler 90 ¡¡ $+ $nopnick($did(Autojoin_Controler,10).seltext,0)
}
on *:dialog:Autojoin_Controler:sclick:20:{
  var %auto_join_chan = $read(auto_join.txt,1)
  /set %Ãß°¡Ã¤³Î $$?="Ãß°¡ÇÒ Ã¤³Î¸íÀº? (¾Õ¿¡ #±îÁö ½áÁÖ¼¼¿ä Å°¿öµå°¡ ÀÖ´Â¹æÀº Ã¤³Î¾È¿¡¼­ !ÀÚµ¿Á¶ÀÎ ÀÌ¶ó ¿ÜÄ¡½Ã¸é µË´Ï´Ù.)"
  write -c auto_join.txt
  write auto_join.txt %auto_join_chan %Ãß°¡Ã¤³Î 
  write auto_join_list.txt %Ãß°¡Ã¤³Î
  /did -a Autojoin_Controler 10 %Ãß°¡Ã¤³Î
  /unset %Ãß°¡Ã¤³Î
} 

on *:dialog:Autojoin_Controler:sclick:30:{
  if ($did(Autojoin_Controler,10).seltext == $null) { echo -a $mini 4 $+ »èÁ¦ÇÒ Ã¤³ÎÀ» ¸ñ·Ï¿¡¼­ ¼±ÅÃÇØ ÁÖ¼¼¿ä. }
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
  /dialog -ma °æ°íMSG °æ°íMSG
} 
on *:dialog:°æ°íMSG:sclick:2:{
  /write -c auto_join.txt 
  /write -c auto_join_list.txt
  /did -r Autojoin_Controler 10
}
on *:dialog:°æ°íMSG:sclick:3:{
  halt
}

;; ¿ÀÅä Ã¤³Î ¼³Á¤

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
  .Á¶ÀÎÀÎ»ç[ $+ $iif($readini(autoset.ini,Setting,Joinme) == $null,Off,$readini(autoset.ini,Setting,Joinme)) $+ ] {
    if ( $readini(autoset.ini,Setting,Joinme) == On ) { writeini autoset.ini Setting Joinme Off }
    else { writeini autoset.ini Setting Joinme On }
  }
  .ÀÎ»ç¸Þ¼¼Áö[ $+ $iif($readini(autoset.ini,Setting,Joinmem) == $null,¾øÀ½,$readini(autoset.ini,Setting,Joinmem)) $+ ] { writeini autoset.ini Setting Joinmem $input(Á¶ÀÎÀÎ»ç¸Þ¼¼Áö,1) }
  .-
  .È¯¿µÀÎ»ç[ $+ $iif($readini(autoset.ini,Setting,Join) == $null,Off,$readini(autoset.ini,Setting,Join)) $+ ] {
    if ( $readini(autoset.ini,Setting,Join) == On ) { writeini autoset.ini Setting Join Off }
    else { writeini autoset.ini Setting Join On }
  }
  .È¯¿µ¸Þ¼¼Áö[ $+ $iif($readini(autoset.ini,Setting,Joinm) == $null,¾øÀ½,$readini(autoset.ini,Setting,Joinm)) $+ ] { writeini autoset.ini Setting Joinm $input(È¯¿µÀÎ»ç¸Þ¼¼Áö,1) }
  .-
  .¿ÀÅä¿É[ $+ $iif($readini(autoset.ini,Setting,Autoop) == $null,Off,$readini(autoset.ini,Setting,Autoop)) $+ ] {
    if ( $readini(autoset.ini,Setting,Autoop) == On ) { writeini autoset.ini Setting Autoop Off }
    else { writeini autoset.ini Setting Autoop On }
  }
  .¿ÀÅäº¸ÀÌ½º[ $+ $iif($readini(autoset.ini,Setting,Autovo) == $null,Off,$readini(autoset.ini,Setting,Autovo)) $+ ] {
    if ( $readini(autoset.ini,Setting,Autovo) == On ) { writeini autoset.ini Setting Autovo Off }
    else { writeini autoset.ini Setting Autovo On }
  }
  .-
  .Ã¤³Îµû·Î¼³Á¤À¸·Î { writeini autoset.ini $chan Auto On }
  .-
  -
  $iif($readini(autoset.ini,$chan,Auto) == On,AuTo Set[ $+ $chan $+ ])
  .-
  .Á¶ÀÎÀÎ»ç[ $+ $iif($readini(autoset.ini,$chan,Joinme) == $null,Off,$readini(autoset.ini,$chan,Joinme)) $+ ] {
    if ( $readini(autoset.ini,$chan,Joinme) == On ) { writeini autoset.ini $chan Joinme Off }
    else { writeini autoset.ini $chan Joinme On }
  }
  .ÀÎ»ç¸Þ¼¼Áö[ $+ $iif($readini(autoset.ini,$chan,Joinmem) == $null,¾øÀ½,$readini(autoset.ini,$chan,Joinmem)) $+ ] { writeini autoset.ini $chan Joinmem $input(Á¶ÀÎÀÎ»ç¸Þ¼¼Áö,1) }
  .-
  .È¯¿µÀÎ»ç[ $+ $iif($readini(autoset.ini,$chan,Join) == $null,Off,$readini(autoset.ini,$chan,Join)) $+ ] {
    if ( $readini(autoset.ini,$chan,Join) == On ) { writeini autoset.ini $chan Join Off }
    else { writeini autoset.ini $chan Join On }
  }
  .È¯¿µ¸Þ¼¼Áö[ $+ $iif($readini(autoset.ini,$chan,Joinm) == $null,¾øÀ½,$readini(autoset.ini,$chan,Joinm)) $+ ] { writeini autoset.ini $chan Joinm $input(È¯¿µÀÎ»ç¸Þ¼¼Áö,1) }
  .-
  .¿ÀÅä¿É[ $+ $iif($readini(autoset.ini,$chan,Autoop) == $null,Off,$readini(autoset.ini,$chan,Autoop)) $+ ] {
    if ( $readini(autoset.ini,$chan,Autoop) == On ) { writeini autoset.ini $chan Autoop Off }
    else { writeini autoset.ini $chan Autoop On }
  }
  .¿ÀÅäº¸ÀÌ½º[ $+ $iif($readini(autoset.ini,$chan,Autovo) == $null,Off,$readini(autoset.ini,$chan,Autovo)) $+ ] {
    if ( $readini(autoset.ini,$chan,Autovo) == On ) { writeini autoset.ini $chan Autovo Off }
    else { writeini autoset.ini $chan Autovo On }
  }
  .-
  .ÀüÃ¼Ã¤³Î¼³Á¤À¸·Î { writeini autoset.ini $chan Auto Off }
  .-
  ÀÚµ¿Á¶ÀÎ¼³Á¤: {  /dialog -ma Autojoin_Controler Autojoin_Controler }
  ÅäÇÈº¯°æ : { ST $chan }
}
;; °Ë»öÅø
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
  button "°Ë»ö", 4, 158 0 34 10, ok
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
        did -i mirc_tool 3 1 ³×ÀÌ¹ö
        did -i mirc_tool 3 2 ¿¥ÆÄ½º
        did -i mirc_tool 3 3 ±¸±Û
        did -i mirc_tool 3 4 ¾ßÈÄ
        did -i mirc_tool 3 5 ´ÙÀ½
        did -c mirc_tool 3 1
      }
      if ( $did(mirc_tool,2).sel == 2 ) {
        did -r mirc_tool 3 
        did -i mirc_tool 3 1 ¾ßÈÄ
        did -i mirc_tool 3 2 ¿¥ÆÄ½º
        did -c mirc_tool 3 1
      }
      if ( $did(mirc_tool,2).sel == 3 ) {
        did -r mirc_tool 3 
        did -i mirc_tool 3 1 ¸ÅÀÏ°æÁ¦
        did -c mirc_tool 3 1
      }
      if ( $did(mirc_tool,2).sel == 4 ) {
        did -r mirc_tool 3 
        did -i mirc_tool 3 1 ¸¶ÀÌÆú´õ
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
  did -i mirc_tool 2 1 °Ë»ö ¿£Áø
  did -i mirc_tool 2 2 ¿µ¾î »çÀü
  did -i mirc_tool 2 3 ½Å¹® °Ë»ö
  did -i mirc_tool 2 4 S/W  °Ë»ö
  did -c mirc_tool 2 1
  did -r mirc_tool 3
  did -i mirc_tool 3 1 ³×ÀÌ¹ö
  did -i mirc_tool 3 2 ¿¥ÆÄ½º
  did -i mirc_tool 3 3 ±¸±Û 
  did -i mirc_tool 3 4 ¾ßÈÄ
  did -i mirc_tool 3 5 ´ÙÀ½ 
  did -c mirc_tool 3 1
}

alias topicgo {
  tokenize 32 $strip($1-)
  /say 14Connect :12 $chan($chan).topic 14¼­¹ö·Î Á¢¼ÓÇÕ´Ï´Ù.  $logo  
  run steam://connect/ $+ $replace($remove($1-,$3-,;password  ), $2 , / $+ $2)
  if ( %ingametray == 1 ) {
    /showmirc -n
  }
}
alias hltopicgo {
  tokenize 32 $strip($1-)
  /say 4HLTV :12 $chan($chan).topic 14¼­¹ö·Î Á¢¼ÓÇÕ´Ï´Ù.  $logo  
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
