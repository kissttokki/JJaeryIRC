; ufo iRC 
; Hanirc. #ufo
; Creator : AmiE,pAndOricA
; E-Mail : papa7545@naver.com
; ���ܼ���, ����� ��
; �� �ƾ⾾�� TeamCrazy iRc �������� ����Ͽ� ���� & ���� ���� �˸��ϴ�.
;### MDX.dll, Sin.dll ������ �ִ� ��θ� �����Ѵ�.
alias -l SMDX return scripts\MDX.dll
alias -l SSin return scripts\Sin.dll

;### ��������
alias -l sround { return $round($calc($1 / 1024^2),2) }
alias -l alof { return $bytes($1).suf }

;### /Sin ������� ���۵� �������� CPU ��뷮 ���� �޾Ƶ��δ�.
;### $1 = ��뷮 ���Դϴ� ( %% )
on 1:signal:cpusagea: {
  if ($dialog(sin)) {
    ;### �������� �ѷ��ش�.
    did -ra sin 2 $1
    did -ra sin 3 $1 $+ %
  }
}

on 1:signal:interface: {
  if ($dialog(sin)) {
    did -ra sin 10  ����:  $sround($1) $+ MB (S: $bytes($2,speed).suf $+ /s) 
    did -ra sin 11  ����:  $sround($3) $+ MB (S: $bytes($4,speed).suf $+ /s)
  }
}


;### /Sin ������� ���۵� �������� Memory ��뷮 ���� �޾Ƶ��δ�.
;### $1 = ��ü �޸�, $2 = ��� �޸�, $3 = ���� �޸�, $4 = ��뷮 �� ( %% )
on 1:signal:memoryusagea: {
  if ($dialog(sin)) {
    ;### �������� �ѷ��ش�.
    did -ra sin 8  $sround($3) $+ / $+  $sround($1) $+ MB (free: $sround($2) $+ MB)
    did -ra sin 6 $4
    did -ra sin 7 $4 $+ %
  }
}

dialog sin {
  title "CPU / Memory ����"
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
  ;### ĵ�� ��ư �Ǵ�, ��� X ��ư�� ������ ���, â ������ �ν� ��, CPU�� �޸� �����带 �����Ѵ�.
  if ($devent == close) {
    .dll scripts/Sin.dll StopAll -
  }
}

;### /Sin ������� CPU, Memory �޸� ��뷮 ����â�� �����Ѵ�.
alias sin {
  ;### ��뷮 ����â�� ���� �ִ��� üũ�Ѵ�.
  ;### â�� ���� ���� ��쿡�� â�� �ݰ�, �ٽ� â�� �����Ѵ�.
  if ($dialog(sin)) {
    dialog -x sin sin
    dialog -ma sin sin
  }
  ;### â�� ���� ���� �ʴٸ�, �ٷ� �����Ѵ�.
  else {
    .dialog -ma sin sin
    ;### CPU�� Memory �����带 ���ÿ� ������.
    ;500^1000�� ^ ���� �����Ͽ�, ���� �ð��� CPU ���� �ð��� �޸� ���� �ð��� ���մϴ�. (���� 1�� = 1000)
    ;98/ME�� ��쿡�� �ð��� ª�� ������ ��� ������ ������ ���� �� �ֽ��ϴ�. 
    .dll Scripts/Sin.dll StartAll 500^1150
  }
}


alias SystemInfo {
  say 2����1�� 2M y 1System_InfomatioN       $logo
  say 2����1�� 1���μ���0___14�� $dll($SSin,GetCPU,Name) �� $dll($SSin,GetCPU,Speed) $+ Mhz ��
  say 2����1�� 1�ü��0___14�� $dll($SSin,GetOSVersion,.)
  say 2����1�� 1��Ʈ��ũ0___14�� $dll($SSin,GetInterface,Desc) $round($calc($dll($SSin,GetInterface,Speed) / 1000^2),2) $+ Mb/s
  say 2����1�� 1����ī��0_14�� $Dll($SSin,GetAudioDevice,.)
  say 2����1�� 1�׷���ī��0_14�� $dll($SSin,GetDisplay,Device)
  say 2����1�� 1�޸�����0_14�� $sround($dll($SSin,GetMemory,APM)) $+ / $+ $sround($dll($SSin,GetMemory,TPM)) $+ MB �� ���� �޸𸮰�: $sround($dll($SSin,GetMemory,FPM)) $+ MB ��
}

alias detailSystemInfo {
  window -d @�ý������� -1 -1 650 440
  echo -a $logo ����������14---=5 Get 4SystemInFo 14=---
  echo -a 
  echo -a 12�ü������: $dll($SSin,GetOSVersion,.)
  echo -a 12���μ�������:
  echo -a ������������ �𡡵� -> $dll($SSin,GetCPU,Name)
  echo -a ������������ Ŭ���� -> $dll($SSin,GetCPU,Speed) $+ Mhz 7 //  $round($calc($dll($SSin,GetCPU,Speed) / 1000),2) $+ Ghz
  echo -a ������������ ĳ���� -> 7#1 $dll($SSin,GetCPU,Cache1) 7#2 $dll($SSin,GetCPU,Cache2) 7#3 $dll($SSin,GetCPU,Cache3)
  echo -a ������������ ������ -> $dll($SSin,GetCPU,Support)
  echo -a 12��Ʈ��ũ����:
  echo -a ������������ �塡ġ -> $dll($SSin,GetInterface,Desc)
  echo -a ������������ �ӡ��� -> $round($calc($dll($SSin,GetInterface,Speed) / 1000^2),2) $+ Mb/s
  echo -a ������������ ������ -> $dll($SSin,GetInterface,Type)
  echo -a ������������ ���� -> $dll($SSin,GetInterface,AdminStatus)
  echo -a ������������ �ޡ��� -> $sround($dll($SSin,GetInterface,InData)) $+ MB 7 /  $dll($SSin,GetInterface,InData) Bytes
  echo -a ������������ ������ -> $sround($dll($SSin,GetInterface,OutData)) $+ MB 7 /  $dll($SSin,GetInterface,OutData) Bytes
  echo -a 12�޸�������:
  echo -a ������������ ����ü -> $sround($dll($SSin,GetMemory,ASM)) $+ / $+ $sround($dll($SSin,GetMemory,TSM)) $+ MB (��밡��: $sround($dll($SSin,GetMemory,FSM)) $+ MB)
  echo -a ������������ �ǡ��� -> $sround($dll($SSin,GetMemory,APM)) $+ / $+ $sround($dll($SSin,GetMemory,TPM)) $+ MB (��밡��: $sround($dll($SSin,GetMemory,FPM)) $+ MB)
  echo -a ������������ ������ -> $sround($dll($SSin,GetMemory,AVM)) $+ / $+ $sround($dll($SSin,GetMemory,TVM)) $+ MB (��밡��: $sround($dll($SSin,GetMemory,FVM)) $+ MB)
  echo -a ������������ ������ -> $sround($dll($SSin,GetMemory,AFM)) $+ / $+ $sround($dll($SSin,GetMemory,TFM)) $+ MB (��밡��: $sround($dll($SSin,GetMemory,FFM)) $+ MB / ����ũ��: $sround($dll($SSin,GetMemory,PFS)) $+ MB)
  echo -a 12��ũ������:
  var %a = 99,%f,%p,%t,%z,%y
  while (%a <= 122) {
    %y = $chr(%a)
    if ($disk(%y)) {
      inc %t $disk(%y).size
      inc %f $disk(%y).free
      set %p $int($calc(($disk(%y).free / $disk(%y).size)*100)) $+ %
      echo -a  ������������ $upper($addtok(%y,����̺� ->,0)) ��: $addtok($disk(%y).label,$chr(3),0) 7:: ��ü: $alof($disk(%y).size) 7/ ���: $alof($calc($disk(%y).size - $disk(%y).free)) 7/ ��밡��: $alof($disk(%y).free) 7: %p
    }
    inc %a
  }
  echo -a 12���÷��̡�:
  echo -a ������������ �塡ġ -> $dll($SSin,GetDisplay,Device)
  echo -a ������������ Į���� -> $dll($SSin,GetDisplay,Color) Bits
  echo -a ������������ �ȡ��� -> $dll($SSin,GetDisplay,Pixel) Pixel
  echo -a ������������ �ֻ��� -> $dll($SSin,GetDisplay,Frequency) Hz
  echo -a 12�����������: $Dll($SSin,GetAudioDevice,.)
}

ON *:load: {
  echo -a 
  echo -a ####### ��� ���� -> /systeminfo
  echo -a ####### CPU, Memory ���� -> /Sin
  echo -a 
}
