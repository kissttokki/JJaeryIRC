; ufo iRC 
; Hanirc. #ufo
; Creator : AmiE,pAndOricA
; E-Mail : papa7545@naver.com
; 무단수정, 재배포 ⓧ
; 본 아얄씨는 TeamCrazy iRc 제작자의 허락하에 수정 & 배포 함을 알립니다.
;### MDX.dll, Sin.dll 파일이 있는 경로를 설정한다.
alias -l SMDX return scripts\MDX.dll
alias -l SSin return scripts\Sin.dll

;### 컨비젼스
alias -l sround { return $round($calc($1 / 1024^2),2) }
alias -l alof { return $bytes($1).suf }

;### /Sin 명령으로 시작된 쓰레드의 CPU 사용량 값을 받아들인다.
;### $1 = 사용량 값입니다 ( %% )
on 1:signal:cpusagea: {
  if ($dialog(sin)) {
    ;### 받은값을 뿌려준다.
    did -ra sin 2 $1
    did -ra sin 3 $1 $+ %
  }
}

on 1:signal:interface: {
  if ($dialog(sin)) {
    did -ra sin 10  받음:  $sround($1) $+ MB (S: $bytes($2,speed).suf $+ /s) 
    did -ra sin 11  보냄:  $sround($3) $+ MB (S: $bytes($4,speed).suf $+ /s)
  }
}


;### /Sin 명령으로 시작된 쓰레드의 Memory 사용량 값을 받아들인다.
;### $1 = 전체 메모리, $2 = 사용 메모리, $3 = 남음 메모리, $4 = 사용량 값 ( %% )
on 1:signal:memoryusagea: {
  if ($dialog(sin)) {
    ;### 받은값을 뿌려준다.
    did -ra sin 8  $sround($3) $+ / $+  $sround($1) $+ MB (free: $sround($2) $+ MB)
    did -ra sin 6 $4
    did -ra sin 7 $4 $+ %
  }
}

dialog sin {
  title "CPU / Memory 사용률"
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
  ;### 캔슬 버튼 또는, 상단 X 버튼을 눌렀을 경우, 창 닫음을 인식 후, CPU와 메모리 쓰레드를 중지한다.
  if ($devent == close) {
    .dll scripts/Sin.dll StopAll -
  }
}

;### /Sin 명령으로 CPU, Memory 메모리 사용량 정보창을 오픈한다.
alias sin {
  ;### 사용량 정보창이 열려 있는지 체크한다.
  ;### 창이 열려 있을 경우에는 창을 닫고, 다시 창을 오픈한다.
  if ($dialog(sin)) {
    dialog -x sin sin
    dialog -ma sin sin
  }
  ;### 창이 열려 있지 않다면, 바로 오픈한다.
  else {
    .dialog -ma sin sin
    ;### CPU와 Memory 쓰레드를 동시에 돌린다.
    ;500^1000은 ^ 으로 구분하여, 앞의 시간은 CPU 뒤의 시간은 메모리 갱신 시간을 뜻합니다. (단위 1초 = 1000)
    ;98/ME의 경우에는 시간을 짧게 설정할 경우 딜레이 현상이 생길 수 있습니다. 
    .dll Scripts/Sin.dll StartAll 500^1150
  }
}


alias SystemInfo {
  say 2─━1♬ 2M y 1System_InfomatioN       $logo
  say 2─━1♬ 1프로세서0___14│ $dll($SSin,GetCPU,Name) 〔 $dll($SSin,GetCPU,Speed) $+ Mhz 〕
  say 2─━1♬ 1운영체제0___14│ $dll($SSin,GetOSVersion,.)
  say 2─━1♬ 1네트워크0___14│ $dll($SSin,GetInterface,Desc) $round($calc($dll($SSin,GetInterface,Speed) / 1000^2),2) $+ Mb/s
  say 2─━1♬ 1사운드카드0_14│ $Dll($SSin,GetAudioDevice,.)
  say 2─━1♬ 1그래픽카드0_14│ $dll($SSin,GetDisplay,Device)
  say 2─━1♬ 1메모리정보0_14│ $sround($dll($SSin,GetMemory,APM)) $+ / $+ $sround($dll($SSin,GetMemory,TPM)) $+ MB 〔 여유 메모리값: $sround($dll($SSin,GetMemory,FPM)) $+ MB 〕
}

alias detailSystemInfo {
  window -d @시스템정보 -1 -1 650 440
  echo -a $logo 　　　　　14---=5 Get 4SystemInFo 14=---
  echo -a 
  echo -a 12운영체제　　: $dll($SSin,GetOSVersion,.)
  echo -a 12프로세스　　:
  echo -a 　　　　　　 모　델 -> $dll($SSin,GetCPU,Name)
  echo -a 　　　　　　 클　럭 -> $dll($SSin,GetCPU,Speed) $+ Mhz 7 //  $round($calc($dll($SSin,GetCPU,Speed) / 1000),2) $+ Ghz
  echo -a 　　　　　　 캐　쉬 -> 7#1 $dll($SSin,GetCPU,Cache1) 7#2 $dll($SSin,GetCPU,Cache2) 7#3 $dll($SSin,GetCPU,Cache3)
  echo -a 　　　　　　 지　원 -> $dll($SSin,GetCPU,Support)
  echo -a 12네트워크　　:
  echo -a 　　　　　　 장　치 -> $dll($SSin,GetInterface,Desc)
  echo -a 　　　　　　 속　도 -> $round($calc($dll($SSin,GetInterface,Speed) / 1000^2),2) $+ Mb/s
  echo -a 　　　　　　 형　식 -> $dll($SSin,GetInterface,Type)
  echo -a 　　　　　　 상　태 -> $dll($SSin,GetInterface,AdminStatus)
  echo -a 　　　　　　 받　음 -> $sround($dll($SSin,GetInterface,InData)) $+ MB 7 /  $dll($SSin,GetInterface,InData) Bytes
  echo -a 　　　　　　 보　냄 -> $sround($dll($SSin,GetInterface,OutData)) $+ MB 7 /  $dll($SSin,GetInterface,OutData) Bytes
  echo -a 12메모리정보　:
  echo -a 　　　　　　 전　체 -> $sround($dll($SSin,GetMemory,ASM)) $+ / $+ $sround($dll($SSin,GetMemory,TSM)) $+ MB (사용가능: $sround($dll($SSin,GetMemory,FSM)) $+ MB)
  echo -a 　　　　　　 실　제 -> $sround($dll($SSin,GetMemory,APM)) $+ / $+ $sround($dll($SSin,GetMemory,TPM)) $+ MB (사용가능: $sround($dll($SSin,GetMemory,FPM)) $+ MB)
  echo -a 　　　　　　 가　상 -> $sround($dll($SSin,GetMemory,AVM)) $+ / $+ $sround($dll($SSin,GetMemory,TVM)) $+ MB (사용가능: $sround($dll($SSin,GetMemory,FVM)) $+ MB)
  echo -a 　　　　　　 페이지 -> $sround($dll($SSin,GetMemory,AFM)) $+ / $+ $sround($dll($SSin,GetMemory,TFM)) $+ MB (사용가능: $sround($dll($SSin,GetMemory,FFM)) $+ MB / 파일크기: $sround($dll($SSin,GetMemory,PFS)) $+ MB)
  echo -a 12디스크정보　:
  var %a = 99,%f,%p,%t,%z,%y
  while (%a <= 122) {
    %y = $chr(%a)
    if ($disk(%y)) {
      inc %t $disk(%y).size
      inc %f $disk(%y).free
      set %p $int($calc(($disk(%y).free / $disk(%y).size)*100)) $+ %
      echo -a  　　　　　　 $upper($addtok(%y,드라이브 ->,0)) 라벨: $addtok($disk(%y).label,$chr(3),0) 7:: 전체: $alof($disk(%y).size) 7/ 사용: $alof($calc($disk(%y).size - $disk(%y).free)) 7/ 사용가능: $alof($disk(%y).free) 7: %p
    }
    inc %a
  }
  echo -a 12디스플레이　:
  echo -a 　　　　　　 장　치 -> $dll($SSin,GetDisplay,Device)
  echo -a 　　　　　　 칼　라 -> $dll($SSin,GetDisplay,Color) Bits
  echo -a 　　　　　　 픽　셀 -> $dll($SSin,GetDisplay,Pixel) Pixel
  echo -a 　　　　　　 주사율 -> $dll($SSin,GetDisplay,Frequency) Hz
  echo -a 12오디오정보　: $Dll($SSin,GetAudioDevice,.)
}

ON *:load: {
  echo -a 
  echo -a ####### 모두 보기 -> /systeminfo
  echo -a ####### CPU, Memory 사용률 -> /Sin
  echo -a 
}
