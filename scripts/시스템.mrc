; ufo iRC 
; Hanirc. #ufo
; Creator : AmiE,pAndOricA
; E-Mail : papa7545@naver.com
; ¹«´Ü¼öÁ¤, Àç¹èÆ÷ ¨ä
; º» ¾Æ¾â¾¾´Â TeamCrazy iRc Á¦ÀÛÀÚÀÇ Çã¶ôÇÏ¿¡ ¼öÁ¤ & ¹èÆ÷ ÇÔÀ» ¾Ë¸³´Ï´Ù.
;### MDX.dll, Sin.dll ÆÄÀÏÀÌ ÀÖ´Â °æ·Î¸¦ ¼³Á¤ÇÑ´Ù.
alias -l SMDX return scripts\MDX.dll
alias -l SSin return scripts\Sin.dll

;### ÄÁºñÁ¯½º
alias -l sround { return $round($calc($1 / 1024^2),2) }
alias -l alof { return $bytes($1).suf }

;### /Sin ¸í·ÉÀ¸·Î ½ÃÀÛµÈ ¾²·¹µåÀÇ CPU »ç¿ë·® °ªÀ» ¹Þ¾ÆµéÀÎ´Ù.
;### $1 = »ç¿ë·® °ªÀÔ´Ï´Ù ( %% )
on 1:signal:cpusagea: {
  if ($dialog(sin)) {
    ;### ¹ÞÀº°ªÀ» »Ñ·ÁÁØ´Ù.
    did -ra sin 2 $1
    did -ra sin 3 $1 $+ %
  }
}

on 1:signal:interface: {
  if ($dialog(sin)) {
    did -ra sin 10  ¹ÞÀ½:  $sround($1) $+ MB (S: $bytes($2,speed).suf $+ /s) 
    did -ra sin 11  º¸³¿:  $sround($3) $+ MB (S: $bytes($4,speed).suf $+ /s)
  }
}


;### /Sin ¸í·ÉÀ¸·Î ½ÃÀÛµÈ ¾²·¹µåÀÇ Memory »ç¿ë·® °ªÀ» ¹Þ¾ÆµéÀÎ´Ù.
;### $1 = ÀüÃ¼ ¸Þ¸ð¸®, $2 = »ç¿ë ¸Þ¸ð¸®, $3 = ³²À½ ¸Þ¸ð¸®, $4 = »ç¿ë·® °ª ( %% )
on 1:signal:memoryusagea: {
  if ($dialog(sin)) {
    ;### ¹ÞÀº°ªÀ» »Ñ·ÁÁØ´Ù.
    did -ra sin 8  $sround($3) $+ / $+  $sround($1) $+ MB (free: $sround($2) $+ MB)
    did -ra sin 6 $4
    did -ra sin 7 $4 $+ %
  }
}

dialog sin {
  title "CPU / Memory »ç¿ë·ü"
  size -1 -1 236 155
  option pixels
  icon $SSin, 0
  box "CPU", 1, 3 1 230 50
  text "0 0 100", 2, 9 17 190 12
  text "0%", 3, 203 17 25 14
  text "CpuName", 4, 10 32 218 14
  box "Memory", 5, 3 52 230 51
  text "0 0 100", 6, 9 68 190 12
  text "0%", 7, 202 68 25 13
  text "Memory S", 8, 10 83 218 14
  box "Interface", 9, 3 104 230 47
  text "received", 10, 11 118 220 14
  text "sent", 11, 11 133 220 14
}


on *:dialog:sin:*:*: {
  if ($devent == init) {
    dll $SMDX MarkDialog $dname
    dll $SMDX SetBorderStyle 2,6 clientedge
    dll $SMDX SetControlMDX $dname 2 ProgressBar smooth > Sin\ctl_gen.mdx
    dll $SMDX SetControlMDX $dname 6 ProgressBar smooth > Sin\ctl_gen.mdx
    did -ra sin 4  $dll(scripts\Sin.dll,GetCPU,Name)
  }
  ;### Äµ½½ ¹öÆ° ¶Ç´Â, »ó´Ü X ¹öÆ°À» ´­·¶À» °æ¿ì, Ã¢ ´ÝÀ½À» ÀÎ½Ä ÈÄ, CPU¿Í ¸Þ¸ð¸® ¾²·¹µå¸¦ ÁßÁöÇÑ´Ù.
  if ($devent == close) {
    .dll scripts/Sin.dll StopAll -
  }
}

;### /Sin ¸í·ÉÀ¸·Î CPU, Memory ¸Þ¸ð¸® »ç¿ë·® Á¤º¸Ã¢À» ¿ÀÇÂÇÑ´Ù.
alias sin {
  ;### »ç¿ë·® Á¤º¸Ã¢ÀÌ ¿­·Á ÀÖ´ÂÁö Ã¼Å©ÇÑ´Ù.
  ;### Ã¢ÀÌ ¿­·Á ÀÖÀ» °æ¿ì¿¡´Â Ã¢À» ´Ý°í, ´Ù½Ã Ã¢À» ¿ÀÇÂÇÑ´Ù.
  if ($dialog(sin)) {
    dialog -x sin sin
    dialog -ma sin sin
  }
  ;### Ã¢ÀÌ ¿­·Á ÀÖÁö ¾Ê´Ù¸é, ¹Ù·Î ¿ÀÇÂÇÑ´Ù.
  else {
    .dialog -ma sin sin
    ;### CPU¿Í Memory ¾²·¹µå¸¦ µ¿½Ã¿¡ µ¹¸°´Ù.
    ;500^1000Àº ^ À¸·Î ±¸ºÐÇÏ¿©, ¾ÕÀÇ ½Ã°£Àº CPU µÚÀÇ ½Ã°£Àº ¸Þ¸ð¸® °»½Å ½Ã°£À» ¶æÇÕ´Ï´Ù. (´ÜÀ§ 1ÃÊ = 1000)
    ;98/MEÀÇ °æ¿ì¿¡´Â ½Ã°£À» Âª°Ô ¼³Á¤ÇÒ °æ¿ì µô·¹ÀÌ Çö»óÀÌ »ý±æ ¼ö ÀÖ½À´Ï´Ù. 
    .dll Scripts/Sin.dll StartAll 500^1150
  }
}


alias SystemInfo {
  say 2¦¡¦¬1¢Ý 2M y 1System_InfomatioN       $logo
  say 2¦¡¦¬1¢Ý 1ÇÁ·Î¼¼¼­0___14¦¢ $dll($SSin,GetCPU,Name) ¡² $dll($SSin,GetCPU,Speed) $+ Mhz ¡³
  say 2¦¡¦¬1¢Ý 1¿î¿µÃ¼Á¦0___14¦¢ $dll($SSin,GetOSVersion,.)
  say 2¦¡¦¬1¢Ý 1³×Æ®¿öÅ©0___14¦¢ $dll($SSin,GetInterface,Desc) $round($calc($dll($SSin,GetInterface,Speed) / 1000^2),2) $+ Mb/s
  say 2¦¡¦¬1¢Ý 1»ç¿îµåÄ«µå0_14¦¢ $Dll($SSin,GetAudioDevice,.)
  say 2¦¡¦¬1¢Ý 1±×·¡ÇÈÄ«µå0_14¦¢ $dll($SSin,GetDisplay,Device)
  say 2¦¡¦¬1¢Ý 1¸Þ¸ð¸®Á¤º¸0_14¦¢ $sround($dll($SSin,GetMemory,APM)) $+ / $+ $sround($dll($SSin,GetMemory,TPM)) $+ MB ¡² ¿©À¯ ¸Þ¸ð¸®°ª: $sround($dll($SSin,GetMemory,FPM)) $+ MB ¡³
}

alias detailSystemInfo {
  window -d @½Ã½ºÅÛÁ¤º¸ -1 -1 650 440
  echo -a $logo ¡¡¡¡¡¡¡¡¡¡14---=5 Get 4SystemInFo 14=---
  echo -a 
  echo -a 12¿î¿µÃ¼Á¦¡¡¡¡: $dll($SSin,GetOSVersion,.)
  echo -a 12ÇÁ·Î¼¼½º¡¡¡¡:
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ ¸ð¡¡µ¨ -> $dll($SSin,GetCPU,Name)
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ Å¬¡¡·° -> $dll($SSin,GetCPU,Speed) $+ Mhz 7 //  $round($calc($dll($SSin,GetCPU,Speed) / 1000),2) $+ Ghz
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ Ä³¡¡½¬ -> 7#1 $dll($SSin,GetCPU,Cache1) 7#2 $dll($SSin,GetCPU,Cache2) 7#3 $dll($SSin,GetCPU,Cache3)
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ Áö¡¡¿ø -> $dll($SSin,GetCPU,Support)
  echo -a 12³×Æ®¿öÅ©¡¡¡¡:
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ Àå¡¡Ä¡ -> $dll($SSin,GetInterface,Desc)
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ ¼Ó¡¡µµ -> $round($calc($dll($SSin,GetInterface,Speed) / 1000^2),2) $+ Mb/s
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ Çü¡¡½Ä -> $dll($SSin,GetInterface,Type)
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ »ó¡¡ÅÂ -> $dll($SSin,GetInterface,AdminStatus)
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ ¹Þ¡¡À½ -> $sround($dll($SSin,GetInterface,InData)) $+ MB 7 /  $dll($SSin,GetInterface,InData) Bytes
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ º¸¡¡³¿ -> $sround($dll($SSin,GetInterface,OutData)) $+ MB 7 /  $dll($SSin,GetInterface,OutData) Bytes
  echo -a 12¸Þ¸ð¸®Á¤º¸¡¡:
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ Àü¡¡Ã¼ -> $sround($dll($SSin,GetMemory,ASM)) $+ / $+ $sround($dll($SSin,GetMemory,TSM)) $+ MB (»ç¿ë°¡´É: $sround($dll($SSin,GetMemory,FSM)) $+ MB)
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ ½Ç¡¡Á¦ -> $sround($dll($SSin,GetMemory,APM)) $+ / $+ $sround($dll($SSin,GetMemory,TPM)) $+ MB (»ç¿ë°¡´É: $sround($dll($SSin,GetMemory,FPM)) $+ MB)
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ °¡¡¡»ó -> $sround($dll($SSin,GetMemory,AVM)) $+ / $+ $sround($dll($SSin,GetMemory,TVM)) $+ MB (»ç¿ë°¡´É: $sround($dll($SSin,GetMemory,FVM)) $+ MB)
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ ÆäÀÌÁö -> $sround($dll($SSin,GetMemory,AFM)) $+ / $+ $sround($dll($SSin,GetMemory,TFM)) $+ MB (»ç¿ë°¡´É: $sround($dll($SSin,GetMemory,FFM)) $+ MB / ÆÄÀÏÅ©±â: $sround($dll($SSin,GetMemory,PFS)) $+ MB)
  echo -a 12µð½ºÅ©Á¤º¸¡¡:
  var %a = 99,%f,%p,%t,%z,%y
  while (%a <= 122) {
    %y = $chr(%a)
    if ($disk(%y)) {
      inc %t $disk(%y).size
      inc %f $disk(%y).free
      set %p $int($calc(($disk(%y).free / $disk(%y).size)*100)) $+ %
      echo -a  ¡¡¡¡¡¡¡¡¡¡¡¡ $upper($addtok(%y,µå¶óÀÌºê ->,0)) ¶óº§: $addtok($disk(%y).label,$chr(3),0) 7:: ÀüÃ¼: $alof($disk(%y).size) 7/ »ç¿ë: $alof($calc($disk(%y).size - $disk(%y).free)) 7/ »ç¿ë°¡´É: $alof($disk(%y).free) 7: %p
    }
    inc %a
  }
  echo -a 12µð½ºÇÃ·¹ÀÌ¡¡:
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ Àå¡¡Ä¡ -> $dll($SSin,GetDisplay,Device)
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ Ä®¡¡¶ó -> $dll($SSin,GetDisplay,Color) Bits
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ ÇÈ¡¡¼¿ -> $dll($SSin,GetDisplay,Pixel) Pixel
  echo -a ¡¡¡¡¡¡¡¡¡¡¡¡ ÁÖ»çÀ² -> $dll($SSin,GetDisplay,Frequency) Hz
  echo -a 12¿Àµð¿ÀÁ¤º¸¡¡: $Dll($SSin,GetAudioDevice,.)
}

ON *:load: {
  echo -a 
  echo -a ####### ¸ðµÎ º¸±â -> /systeminfo
  echo -a ####### CPU, Memory »ç¿ë·ü -> /Sin
  echo -a 
}
