alias -l GetLibrary { return SpeedCheck.dll }
;; ip nick
#trace off
raw 352:*: { 
  inc %trace.counter
  if (%trace.counter > 3) { msg $active %logo �˻��� ����� 3�� �̻��Դϴ�. ���� ������ �����Ͽ� �˻����ּ���. | unset %trace | .disable #trace }
  else { msg $active %logo 0,4��4����[ $6 ] 0,3��3����[ $4 ] 0,12ä12��[ $2 ] 0,14��14���ڸ�[ $3 ] }
  halt
}
raw 315:*: { .disable #trace  | halt }
#trace end

#trace2 off
raw 352:*: { 
  echo $active %logo 0,4��4����[ $6 ] 0,3��3����[ $4 ] 0,12ä12��[ $2 ] 0,14��14���ڸ�[ $3 ]
  halt
}
raw 315:*: { .disable #trace2  | halt }
#trace2 end

raw 205:*: { 
  msg $active %logo $4
  halt 
}
;; æ��
alias Chanserv_info { 
  sockclose Chanserv_info
  sockopen Chanserv_info pink.the-7.net 80 
}

;;--sock�Է�part--;;

On 1:sockopen:Chanserv_info:sockwrite -nt Chanserv_info GET http://hanirc-chanstat.the-7.net/csqual.cgi?channel= $+ %Chanserv_chan 

;;--Web_temp ����part--;;

On *:sockread:Chanserv_info: { 
  sockread %Chanserv_temp
  if ( �������� isin %Chanserv_temp ) {
    set %Chanserv_error $chr(91) 4- Error - $chr(93) $chr(35) $+ %Chanserv_chan ä�ο� ���� ������ �������� �ʽ��ϴ�.
    halt
  }
  else if ( ����</TD><TD> isin %Chanserv_temp ) {
    set %Chanserv_msg1 7�ο� 10�� �Ѵ� ���� �� $remove(%Chanserv_temp,<TR><TD>10�� �Ѵ� ����</TD><TD>,</TD></TR>) 
    halt
  }
  else if ( �ο�</TD><TD> isin %Chanserv_temp ) {
    set %Chanserv_msg2 7��� �ο� �� $remove(%Chanserv_temp,<TR><TD>��� �ο�</TD><TD>,</TD></TR>)
    halt
  }
  else if ( ����</TD><TD> isin %Chanserv_temp ) { 
    set %Chanserv_msg3 7��뵵 ���� �� $remove(%Chanserv_temp,<TR><TD>��뵵 ����</TD><TD>,</TD></TR>)
    halt
  }
  else if ( �ڰ�</TD><TD> isin %Chanserv_temp ) { 
    if ( ȸ���˴ϴ�.</font></TABLE></TD></TR> isin %Chanserv_temp ) {
      set %Chanserv_msg4 7æ�� ��û �ڰ� �� ��û �� �� �����ϴ�.Chanserv �� �ִ��� ȸ���˴ϴ�.
      halt
    }
    else if ( ��û�Ͻñ� isin %Chanserv_temp ) {
      set %Chanserv_msg4 7æ�� ��û �ڰ� �� ��û �� �� �ֽ��ϴ�.����� �ѹ� �� Ȯ���Ͻð� ��û�Ͻñ� �ٶ��ϴ�.
      halt
    }
    else if ( ���� �ð� isin %Chanserv_temp ) {
      set %Chanserv_msg4 7æ�� ��û �ڰ� �� ��û �� �� �����ϴ�. ä�� ����ð� �ʰ��Դϴ�.
    }
    else if ( ��뵵 ���� isin %Chanserv_temp ) {
      set %Chanserv_msg4 7æ�� ��û �ڰ� �� ��û �� �� �����ϴ�. ��뵵 ���� �̴��Դϴ�.
    }
  }
} 

;;--sock���part--;;

on *:sockclose:Chanserv_info: {
  if ( %Chanserv_error != $null ) {
    msg %chanservinfo_chan 10 $+ $chr(35) $+  %Chanserv_chan ä�� Chanserv ��û�ڰ� Info... 
    msg %chanservinfo_chan %Chanserv_error
    msg %chanservinfo_chan --- Copyright(C) HanIRC Operator Group, 2004. --- 
    unset %Chanserv_*
    halt
  }
  else if ( %Chanserv_error == $null ) {
    msg %chanservinfo_chan 10 $+ $chr(35) $+ %Chanserv_chan ä�� Chanserv ��û�ڰ� Info...
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
  if ( $1 == !ä�� ) {
    /say $1
    /say �� 2 $opnick(#,0) �� ��� : 4 $nopnick(#,0) �� ���̽� : 6 $vnick(#,0) �� ���̽� : 10 $nvnick(#,0) �� �� 12 $nick(#,0,a) �� �Դϴ�.
    halt
  }
  if ($1- == !����) {
    /ip
  halt }
  if ($1- == !�ԽǼ�) {
    /say $1
    /say 15[14 $+ $me $+ 15]12 �Բ��� �Խ��� ä���� ���� 15[14 $+ $chan(0) $+ 15]12 �� �Դϴ�.  $logo
  halt }

  if (($1 == !����) && ($2-)) {
    /say !���� $2-
    /whois $2-
  halt } 

  if ($1 == !�ҽ�) {
    if (%steamdir == $null) {
      /say $1-
      /say ������ ��ΰ� �������� �ʾҽ��ϴ�. '!����'�� �ϼż� ������ ��θ� �������ֽñ� �ٶ��ϴ�. 
      halt
    }
    else {
      /say $1-
      /say 12 $me 1 is 3 $2-  1connecting...
      /run %SteamDIR -applaunch 240 -console %������ +connect $remove$+ $2-
    halt }
  }
  if ($1 == !����) {
    if (%steamdir == $null) {
      /say $1-
      /say ������ ��ΰ� �������� �ʾҽ��ϴ�. '!����'�� �ϼż� ������ ��θ� �������ֽñ� �ٶ��ϴ�. 
      halt
    }
    else {
      /say $1-
      /say 12 $me 1 is 3 $2-  1connecting...
      /run %SteamDIR -applaunch 70 -console %������ +connect $remove$+ $2-
    halt }
  }
  if (($1 == !����) && ($2-)) {
    /say !���� $2-
    /version $2-
  halt }
  IF ($1- == !Ʈ����) {
    /say $1
    /amsg 14 â�� Ʈ���̻��·� ��ȯ�մϴ�. $logo
    /showmirc -t
  halt }
  IF ($1- == !����) {
    /say $1
    /SystemInfo
  halt }
  IF ($1- == !����) {
    /say $1
    /say 14Dialog 7Loading1 ...14 �� 3Cool Mp3 Player14 �ݦ��������� $logo
    /mp3_p
  halt }
  IF ($1- == !����) {
    /say $1
    /say 14Dialog 7Loading1 ...14 �� 3Cool Mp3 Player14 �ݦ��������� $logo
    /mp3_p
  halt }
  if ($1 == !����) {
    if (%steamdir == $null) {
      /say $1-
      /say ������ ��ΰ� �������� �ʾҽ��ϴ�. '!����'�� �ϼż� ������ ��θ� �������ֽñ� �ٶ��ϴ�. 
      /run http://cdn.steampowered.com/download/SteamInstall.msi
      halt
    }
    elseif (%steamdir != $2-) {
      .say $1-
      .say 14Program 7Loading1 ...14 �� 3Steam14 �ݦ��������� $logo
      .run %steamdir
      halt
    }   
  }
  if ($1 == !SXE) {
    if (%sxedir == $null) {
      /say $1-
      /say sXe Injected�� ��ΰ� �������� �ʾҽ��ϴ�. '!����'�� �ϼż� sXe�� ��θ� �������ֽñ� �ٶ��ϴ�. 
      /run http://www.sxe-injected.com/downloads
      halt
    }
    elseif (%sxedir != $2-) {
      .say $1-
      .say 14Program 7Loading ...14 �� 3sXe Injected14 �ݦ��������� $logo
      .run %sxedir 
      halt
    }
  }
  if ($1 == !hl || $1 == !hltv) {
    if (%hltvdir == $null) {
      /say $1-
      /say HLTV�� ��ΰ� �������� �ʾҽ��ϴ�. '!����'�� �ϼż� HLTV�� ��θ� �������ֽñ� �ٶ��ϴ�. 
      halt
    }
    elseif (%hltvdir != $2-) {
      .say $1-
      .say 14Program 7Loading ...14 �� 3HLTV14 �ݦ��������� $logo
      .run -p %hltvdir
      .halt
    }
  }
  if ($1- == !ī��) {
    if (%csodir == $null) {
      /say $1-
      /say ī���¶����� ��ΰ� �������� �ʾҽ��ϴ�. '!����'�� �ϼż� ��θ� �������ֽñ� �ٶ��ϴ�. 
      halt
    }
    elseif (%csodir != $2-) {
      .say $1-
      .say 14Program 7Loading1 ...14 �� 3Counter Strike : Online14 �ݦ��������� $logo
      .run -p %csodir
      if ( %ingametray == 1 ) {
        /showmirc -n
      }
      halt
    }   
  }
  IF ($1- == !����Ʈ) {
    /site
  halt } 
  if (($1 == !��)) {
    if ($2 == $null ) { .say !�� | /run C:\Program Files\Internet Explorer\iexplore.exe | /halt }
    /say !�� http:// $+ $remove($2,http://)
    /say 14Web 7Loading ...14 ��3 http:// $+ $remove($2,http://) 14�ݦ��������� $logo
    /run http:// $+ $remove($2,http://)
  halt } 
  if (($1 == !��2)) {
    if ($2 == $null ) { .echo $mini !��2 �ڿ� ���ּҸ� �Է��ϼ���. | /halt }
    /say !��2 http:// $+ $remove($2,http://)
    /say 14Web 7Loading ...14 ��3 http:// $+ $remove($2,http://) 14�ݦ��������� $logo
    /ircweb http:// $+ $remove($2,http://)
  halt }
  IF ($1- == !�ð�) {
    /times
  halt } 
  IF ($1- == !�ֻ�) {
    /jusawe
  halt } 
  IF ($1- == !����) {
    /say $1
    /say 14Program 7Loading ...14 �� 3��뼳��14 �ݦ��������� $logo
    /teamcrazyhelp
  halt }
  if ($1- == !û) {
    /clearall
    /say $1
    /say 14��� â�� û���մϴ�. $logo
  halt }
  if ($1- == !��) {
    /say !��
    /echo �⺻������ �ٲٽ÷��� !���� ���� ���Ӹ�,������ �������� �ٲ��ֽø� �˴ϴ�. (�ٽ� ���ƿ��÷��� !�� �ѹ����ϼ���)
    /setting.update saytit saytit
  halt }
  if ($1- == !��) {
    /say !��
    /memo
  halt }    
  if ($1- == !����) {
    /say !����
    /nick %nickdefault   
  halt }  
  if ($1- == !���) {
    /say !���
    /nick %nick2nd $+ l���
  halt }
  if ($1- == !��) {
    /say !��
    /nick %nick2nd $+ l�Ļ���
  halt }
  if ($1- == !��ü) {
    /say !��ü
    /nick %nick2nd $+ l��ü
  halt }
  if ($1- == !�޽�) {
    /say !�޽�
    /nick %nick2nd $+ l�޽�
  halt }
  if ($1- == !��) {
    /say !��
    /nick %nick2nd $+ l����
  halt }
  if ($1- == !��) {
    /say !��
    /nick %nick2nd $+ l��
  halt }
  if ($1- == !��ġ) {
    /say !��ġ
    /nick %nick2nd $+ l��ġ
  halt }
  if ($1- == !�׸���) {
    /say $1
    /run mspaint
    /say 14Program 7Loading ...14 �� 3�׸���14 �ݦ��������� $logo
  halt }
  if ($1- == !�޸���) {
    /say $1
    /run notepad
    /say 14Program 7Loading ...14 �� 3�޸���14 �ݦ��������� $logo
  halt }
  if ($1- == !û��) {
    /say !û��
    /clear
  halt }
  if ($1- == !����) {
    /say !����
    /ufohelp
  halt }   
  if ($1- == !���޸�) {
    /say !���޸�
    /say $nick 10 �޸𳻿�: 14 %memo
  halt }
  if ($1- == !��) {
    /say !��
    /do
  halt }
  if ($1- == !����) {
    /say !����
    /config
  halt }
  if ($1- == !����) {
    /say !����
    if ( $os == xp || $os == Vista ) {
      ./run shutdown -s -t 00
      /exit
      halt
    }
    else {
      /dll Sd.dll WinMenu
    halt }
  }
  if ($1- == !����) {
    /say !����
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
  if ($1- == !����) {
    /say !����
    /say 14 $chan ���Ȣ� $chan($chan).topic
  halt }
  if ($1 == !���Ȱ�) {
    /say $1-
    topicgo $chan($chan).topic 
  halt } 
  if ($1 == !������) {
    /say $1-
    /var %���ȼ��� $chan($chan).topic 
    /run %sxedir
    /say 14RUN :12 sXe Injected�� �����մϴ�. $logo  
    /sxego
    /echo 4 25�� 14�ȿ� sXe injected �� �ֻ����� Ȱ��ȭ �����ּ���.
    .timerantiflood 1 25 .timersxe off
  halt } 
  if ($1 == !��ٰ�) {
    /say $1-
    /var %���ȼ��� $chan($chan).topic 
    /say 14Run:12 Novacap14 �� �����մϴ�..
    topicgo $chan($chan).topic 
    /run $mircdirutil\Novacap\novacap.exe
    /showmirc -n
  halt }
  if ($1 == !hl���� || $1 == !hl���Ȱ�) {
    /say $1-
    hltopicgo $chan($chan).topic
  halt } 
  if ($1 == !æ��)  {
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
  if ( $1 == !���� ) {
    if ($2) { unset %trace.counter | .enable #trace | .who $2 }
    else { .say $1- |  msg $active %logo ���� : !���� �˻��� 1(* ���ϵ�ī�� ��밡�� ex : !���� *�浿*) | .halt }
  }
  if ( $1 == !@���� ) { .enable #trace2 | .who $2 }
  if ( $1 == !���� ) { .trace $2 }
  if ( $1 == !ã�� ) {
    msg $active $1-
    echo -a $mini ���� �ڼ��� ������ ���Ͻø� 5!���� ������1 �ϼ���.
    set %ipnickv On
    who $2
    halt
  }
  if ($1 == !üũ)  {
    var %Type
    if ( $2 == �ٿ�ε� ) {
      %Type = DN
    }
    else if ( $2 == ���ε� ) {
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
        /say ���ͳ� �ٿ�ε� �ӵ�: %bps ( 4 %bts )
      }
      %temp = $gettok(%Speed,2,$asc(|))
      if ( %temp != - ) {
        %bps = $gettok(%temp,1,$asc(!))
        %bts = $gettok(%temp,2,$asc(!))
        /say ���ͳ� ���ε� �ӵ�: %bps ( 12 %bts )
      }
    }
    else if ( %bResult == S_FAIL ) {
      /echo -a ���ͳ� �ӵ����� ����: $Dll($GetLibrary,GetError,)
    }
    halt
  }
  if ($1 == !�˻�) {
    .say $1-
    if ( $2 == $null ) {
      .say 14Program 7Loading ...14 �� 3�˻�����14 �ݦ��������� $logo
      .mirc_tool_start
      halt
    }
    else {
      .say 14Program 7Loading ...14 �� 3���̹� " $+ $2- $+ " �˻�14 �ݦ��������� $logo
      run http://search.naver.com/search.naver?where=3&oldquery=&restrict=0&field=0&host=&dir=&homepage=0&display=10&start=1&query= $+ $2- $+ 
      halt
    }
  }
  if ($1 == !���̹�) {
    say $1-
    if ($2 == $null) {
      run http://www.naver.com
      .say 14Program 7Loading ...14 �� 3www.naver.com14 �ݦ��������� $logo
    }
    else {
      .say 14Program 7Loading ...14 �� 3���̹� " $+ $2- $+ " �˻�14 �ݦ��������� $logo
      run http://search.naver.com/search.naver?where=3&oldquery=&restrict=0&field=0&host=&dir=&homepage=0&display=10&start=1&query= $+ $2- $+
    }
    halt
  }
  if ($1 == !����) {
    say $1-
    if ($2 == $null) {
      run http://www.google.com
      .say 14Program 7Loading ...14 �� 3www.google.com14 �ݦ��������� $logo
    }
    else {
      .say 14Program 7Loading ...14 �� 3���� " $+ $2- $+ " �˻�14 �ݦ��������� $logo
      run "http://www.google.co.kr/search?q= $+ $2- $+ "
    }
    halt
  }
  if ($1 == !�ٿ�) {
    .say $1-
    .say 14Dialog 7Loading ...14 �� 3Downloader14 �ݦ��������� $logo
    downloader_start
    halt
  }
  if ($1 == !����) {
    .say $1-
    .say 14Reg 7Write1 ...14 �� 3mIRC �������14 �ݦ��������� $logo
    .run $mircdir����.reg
    halt
  }
  if ($1 == !�����) {
    .say $1-
    .say 14Reg 7Write1 ...14 �� 3Geforce �����14 �ݦ��������� $logo
    coolbit
    halt
  }
  if ($1 == !�ڵ�����) {
    if ($2 == $null) {
      say $1-
      if ($chan($active).key != $null) {
        write auto_join_p.txt /join $chan $chan($active).key
        msg $active $logo 4 $chan ä���� Ű����4 $chan($active).key (��)�� �ڵ����ο� �߰��߽��ϴ�.
      }
      else {
        var %auto_join_chan = $read(auto_join.txt,1)
        write -c auto_join.txt
        write auto_join.txt %auto_join_chan $chan
        write auto_join_list.txt $chan
        msg $active $logo 4 $chan ä���� �ڵ����ο� �߰��߽��ϴ�.
        echo -a $mini 4���(Ű����)�� �ڵ������� ���� ���� �ÿ��� �����մϴ�. 
        echo -a $mini 4���� ���� ������� �ڵ������ߴٸ� !�ڵ����� ������ �Ͻ��� ���� �����ð� !�ڵ����� �Ͻñ� �ٶ��ϴ�.
      }
    }
    if ($2 == ����) {
      say $1-
      if ($chan($active).key != $null) {
        write -dw* $+ $active $+ * auto_join_p.txt
        msg $active $logo 4 $chan ä���� �ڵ����ο��� �����߽��ϴ�.
      }
      else {
        var %auto_join_im = $read(auto_join.txt,1)
        var %auto_join_chan = $remove(%auto_join_im,$active)
        write -c auto_join.txt
        write auto_join.txt %auto_join_chan
        write -dw* $+ $active auto_join_list.txt
        msg $active $logo 4 $chan ä���� �ڵ����ο��� �����߽��ϴ�.
      }
    }
    if ($2 == ��λ���) {
      say $1-
      write -c auto_join.txt
      write -c auto_join_p.txt
      write -c auto_join_list.txt
      msg $active $logo 4 ���ä���� �ڵ����ο��� �����߽��ϴ�.
    }
    halt 
  }
  if ($1 == !���μ���) {
    say $1
    say 14Dialog 7Loading ...14 �� 3�ڵ����� Controller14 �ݦ��������� $logo
    /dialog -ma Autojoin_Controler Autojoin_Controler
    halt
  }
}
;; !ã��
alias �˻� { who $1 }
alias who {
  if ( $active != Status Window ) {
    unset %ipnick
    who $1
  }
}

raw 315:*: {
  if ( %ipnickv == on ) {
    msg $active 5�˻����: $+ $iif(%ipnick == $null,�˻��� ����ڰ� �����ϴ�.,%ipnick)
    unset %ipnick %ipnickv
  }
  else { 
    echo $color(info) -a *** �˻����: $+ $iif(%ipnick == $null,�˻��� ����ڰ� �����ϴ�.,%ipnick)
    unset %ipnick %ipnickv
  }
  halt
}

raw 352:*: {
  if ( %ipnickv == on ) {
    if ( $len(%ipnick) <= 400 ) { set %ipnick %ipnick $6 }
    else {
      msg $active 5�˻����: $+ %ipnick
      unset %ipnick
    }
  }
  else {
    if ( $len(%ipnick) <= 400 ) { set %ipnick %ipnick $6 }
    else {
      echo $color(info) -a *** �˻����: $+ %ipnick
      unset %ipnick
    }
  }
  halt
}

raw 416:*: {
  if ( %ipnickv == on ) {
    msg $active 5�����Ͱ� �ʹ� �����ϴ�.
    unset %ipnick %ipnickv
  }
  else {
    echo $color(info) -a *** �����Ͱ� �ʹ� �����ϴ�.
    unset %ipnick %ipnickv
  }
  halt
}

;; ���� setting

alias st {
  if ($active ischan) {
    dialog $iif($dialog(settopic),-v,-m) settopic settopic
    dialog -t settopic Set $active topic (Manu :D)
    did -ra settopic 5 $chan($active).topic
    if ($me isop $active) || ($me ishop $active) || (t !isincs $gettok($chan($chan).mode,1,32)) { did -e settopic 7 }
    if ($topiclen isnum) { did -ra settopic 4 $calc($topiclen - $len($chan($active).topic)) }
    prevtopic
  }
  else { echo $active �� ��ũ���� ���� ü�ο����� �����մϴ�. :D }
}
on *:rawmode:#:{ if (($me isop $chan) || ($me ishop $chan) || (t !isincs $gettok($chan($chan).mode,1,32))) && ($chan == $gettok($dialog(settopic).title,2,32)) { did -e settopic 7 } }
dialog settopic {
  size -1 -1 249 50
  option dbu
  text �ִ� ���� ����:,1,3 3 70 9
  text ���� ���� ���� ����:,2,165 3 70 9
  text $topiclen,3,52 3 15 9,right
  text $topiclen,4,220 3 25 9,right
  edit "",5,2 12 245 11,autohs limit 600
  icon 8,2 23 245 13,topic\ttemp.bmp
  button "���",6,164 37 40 11,cancel
  button "���� :D",7,207 37 40 11,ok disabled
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

ON *:text:*!�޸�:#:/notice $nick 10�޸𳻿�: 14 %memo
on *:text:*!����:#:/notice $nick $logo

;; �ڵ����� ��Ʈ��

dialog Autojoin_Controler {
  title "�ڵ� ä�� ���� ��Ʈ�ѷ�"
  size -1 -1 132 147
  option dbu
  list 10, 10 15 64 113, size vsbar
  box "ä�� ����Ʈ", 1, 4 6 76 128
  button "ä�� �߰�", 20, 91 21 33 11
  button "ä�� ����", 30, 91 34 33 11
  button "ä�� ����", 40, 91 47 33 11
  button "��� ����", 50, 91 60 33 11
  text "ä�� ����", 3, 89 75 29 8
  text "     �� ��", 2, 91 11 32 8
  text "���ο� :", 4, 85 86 25 8
  text "   ��", 60, 108 86 19 8
  text "����� :", 5, 85 95 25 8
  text "   ��", 70, 108 95 19 8
  text "   ��", 80, 108 104 19 8
  text "���̽� :", 6, 85 104 25 8
  text "�Ϲ��� :", 7, 85 113 25 8
  text "   ��", 90, 108 113 19 8
  button "���", 3000, 0 0 0 0, cancel
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
dialog ���MSG {
  title "���!"
  size -1 -1 99 42
  option dbu
  text "�� ����� �����ϰ� �Ǹ�, �ڵ������� ������ ��� ä���� �����˴ϴ�. �׷��� ��� �Ͻðڽ��ϱ�?", 1, 5 5 90 18
  button "��", 2, 4 26 43 12, ok
  button "�ƴϿ�", 3, 52 26 43 12, cancel
}

on *:dialog:Autojoin_Controler:sclick:10:{ 
  did -ra Autojoin_Controler 60 �� $+ $nick($did(Autojoin_Controler,10).seltext,0)
  did -ra Autojoin_Controler 70 �� $+ $opnick($did(Autojoin_Controler,10).seltext,0)
  did -ra Autojoin_Controler 80 �� $+ $vnick($did(Autojoin_Controler,10).seltext,0)
  did -ra Autojoin_Controler 90 �� $+ $nopnick($did(Autojoin_Controler,10).seltext,0)
}
on *:dialog:Autojoin_Controler:sclick:20:{
  var %auto_join_chan = $read(auto_join.txt,1)
  /set %�߰�ä�� $$?="�߰��� ä�θ���? (�տ� #���� ���ּ��� Ű���尡 �ִ¹��� ä�ξȿ��� !�ڵ����� �̶� ��ġ�ø� �˴ϴ�.)"
  write -c auto_join.txt
  write auto_join.txt %auto_join_chan %�߰�ä�� 
  write auto_join_list.txt %�߰�ä��
  /did -a Autojoin_Controler 10 %�߰�ä��
  /unset %�߰�ä��
} 

on *:dialog:Autojoin_Controler:sclick:30:{
  if ($did(Autojoin_Controler,10).seltext == $null) { echo -a $mini 4 $+ ������ ä���� ��Ͽ��� ������ �ּ���. }
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
  /dialog -ma ���MSG ���MSG
} 
on *:dialog:���MSG:sclick:2:{
  /write -c auto_join.txt 
  /write -c auto_join_list.txt
  /did -r Autojoin_Controler 10
}
on *:dialog:���MSG:sclick:3:{
  halt
}

;; ���� ä�� ����

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
  .�����λ�[ $+ $iif($readini(autoset.ini,Setting,Joinme) == $null,Off,$readini(autoset.ini,Setting,Joinme)) $+ ] {
    if ( $readini(autoset.ini,Setting,Joinme) == On ) { writeini autoset.ini Setting Joinme Off }
    else { writeini autoset.ini Setting Joinme On }
  }
  .�λ�޼���[ $+ $iif($readini(autoset.ini,Setting,Joinmem) == $null,����,$readini(autoset.ini,Setting,Joinmem)) $+ ] { writeini autoset.ini Setting Joinmem $input(�����λ�޼���,1) }
  .-
  .ȯ���λ�[ $+ $iif($readini(autoset.ini,Setting,Join) == $null,Off,$readini(autoset.ini,Setting,Join)) $+ ] {
    if ( $readini(autoset.ini,Setting,Join) == On ) { writeini autoset.ini Setting Join Off }
    else { writeini autoset.ini Setting Join On }
  }
  .ȯ���޼���[ $+ $iif($readini(autoset.ini,Setting,Joinm) == $null,����,$readini(autoset.ini,Setting,Joinm)) $+ ] { writeini autoset.ini Setting Joinm $input(ȯ���λ�޼���,1) }
  .-
  .�����[ $+ $iif($readini(autoset.ini,Setting,Autoop) == $null,Off,$readini(autoset.ini,Setting,Autoop)) $+ ] {
    if ( $readini(autoset.ini,Setting,Autoop) == On ) { writeini autoset.ini Setting Autoop Off }
    else { writeini autoset.ini Setting Autoop On }
  }
  .���亸�̽�[ $+ $iif($readini(autoset.ini,Setting,Autovo) == $null,Off,$readini(autoset.ini,Setting,Autovo)) $+ ] {
    if ( $readini(autoset.ini,Setting,Autovo) == On ) { writeini autoset.ini Setting Autovo Off }
    else { writeini autoset.ini Setting Autovo On }
  }
  .-
  .ä�ε��μ������� { writeini autoset.ini $chan Auto On }
  .-
  -
  $iif($readini(autoset.ini,$chan,Auto) == On,AuTo Set[ $+ $chan $+ ])
  .-
  .�����λ�[ $+ $iif($readini(autoset.ini,$chan,Joinme) == $null,Off,$readini(autoset.ini,$chan,Joinme)) $+ ] {
    if ( $readini(autoset.ini,$chan,Joinme) == On ) { writeini autoset.ini $chan Joinme Off }
    else { writeini autoset.ini $chan Joinme On }
  }
  .�λ�޼���[ $+ $iif($readini(autoset.ini,$chan,Joinmem) == $null,����,$readini(autoset.ini,$chan,Joinmem)) $+ ] { writeini autoset.ini $chan Joinmem $input(�����λ�޼���,1) }
  .-
  .ȯ���λ�[ $+ $iif($readini(autoset.ini,$chan,Join) == $null,Off,$readini(autoset.ini,$chan,Join)) $+ ] {
    if ( $readini(autoset.ini,$chan,Join) == On ) { writeini autoset.ini $chan Join Off }
    else { writeini autoset.ini $chan Join On }
  }
  .ȯ���޼���[ $+ $iif($readini(autoset.ini,$chan,Joinm) == $null,����,$readini(autoset.ini,$chan,Joinm)) $+ ] { writeini autoset.ini $chan Joinm $input(ȯ���λ�޼���,1) }
  .-
  .�����[ $+ $iif($readini(autoset.ini,$chan,Autoop) == $null,Off,$readini(autoset.ini,$chan,Autoop)) $+ ] {
    if ( $readini(autoset.ini,$chan,Autoop) == On ) { writeini autoset.ini $chan Autoop Off }
    else { writeini autoset.ini $chan Autoop On }
  }
  .���亸�̽�[ $+ $iif($readini(autoset.ini,$chan,Autovo) == $null,Off,$readini(autoset.ini,$chan,Autovo)) $+ ] {
    if ( $readini(autoset.ini,$chan,Autovo) == On ) { writeini autoset.ini $chan Autovo Off }
    else { writeini autoset.ini $chan Autovo On }
  }
  .-
  .��üä�μ������� { writeini autoset.ini $chan Auto Off }
  .-
  �ڵ����μ���: {  /dialog -ma Autojoin_Controler Autojoin_Controler }
  ���Ⱥ��� : { ST $chan }
}
;; �˻���
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
  button "�˻�", 4, 158 0 34 10, ok
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
        did -i mirc_tool 3 1 ���̹�
        did -i mirc_tool 3 2 ���Ľ�
        did -i mirc_tool 3 3 ����
        did -i mirc_tool 3 4 ����
        did -i mirc_tool 3 5 ����
        did -c mirc_tool 3 1
      }
      if ( $did(mirc_tool,2).sel == 2 ) {
        did -r mirc_tool 3 
        did -i mirc_tool 3 1 ����
        did -i mirc_tool 3 2 ���Ľ�
        did -c mirc_tool 3 1
      }
      if ( $did(mirc_tool,2).sel == 3 ) {
        did -r mirc_tool 3 
        did -i mirc_tool 3 1 ���ϰ���
        did -c mirc_tool 3 1
      }
      if ( $did(mirc_tool,2).sel == 4 ) {
        did -r mirc_tool 3 
        did -i mirc_tool 3 1 ��������
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
  did -i mirc_tool 2 1 �˻� ����
  did -i mirc_tool 2 2 ���� ����
  did -i mirc_tool 2 3 �Ź� �˻�
  did -i mirc_tool 2 4 S/W  �˻�
  did -c mirc_tool 2 1
  did -r mirc_tool 3
  did -i mirc_tool 3 1 ���̹�
  did -i mirc_tool 3 2 ���Ľ�
  did -i mirc_tool 3 3 ���� 
  did -i mirc_tool 3 4 ����
  did -i mirc_tool 3 5 ���� 
  did -c mirc_tool 3 1
}

alias topicgo {
  tokenize 32 $strip($1-)
  /say 14Connect :12 $chan($chan).topic 14������ �����մϴ�.  $logo  
  run steam://connect/ $+ $replace($remove($1-,$3-,;password  ), $2 , / $+ $2)
  if ( %ingametray == 1 ) {
    /showmirc -n
  }
}
alias hltopicgo {
  tokenize 32 $strip($1-)
  /say 4HLTV :12 $chan($chan).topic 14������ �����մϴ�.  $logo  
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
