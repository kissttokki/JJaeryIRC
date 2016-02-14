dialog downf {
  title "Downloader"
  size -1 -1 175 20
  option dbu
  combo 2, 0 0 73 50, size drop
  combo 3, 74 0 60 50, size drop
  button "Download", 4, 135 0 40 10
  text "Program Downloader edit by AmiE", 6, 1 12 173 10, disable
}
on *:dialog:downf:*:*: {
  if ( $devent == sclick ) {
    if ( $did == 2 ) { 
      if ( $did(downf,2).sel == 1 ) {
        did -r downf 3 
        did -i downf 3 1 Client
        did -i downf 3 2 HLTV
        did -i downf 3 3 hlds update tool
        did -c downf 3 1
      }
      if ( $did(downf,2).sel == 2 ) {
        did -r downf 3 
        did -i downf 3 1 -----Utility-----
        did -i downf 3 2 마우스 폴링율 설정
        did -i downf 3 3 마우스 Hz 체커
        did -i downf 3 4 ----Registry----
        did -i downf 3 5 MouseFix
        did -i downf 3 6 MouseFix 제거
        did -i downf 3 7 노포스 적용
        did -i downf 3 8 -----Driver-----
        did -i downf 3 9 Sensei
        did -i downf 3 10 Xai
        did -i downf 3 11 Kinzu+
        did -i downf 3 12 기타
        did -c downf 3 1
      }
      if ( $did(downf,2).sel == 3 ) {
        did -r downf 3 
        did -i downf 3 1 ----Registry----
        did -i downf 3 2 해상도 16비트
        did -i downf 3 3 해상도 32비트
        did -i downf 3 4 그래픽 Opengl
        did -i downf 3 5 그래픽 쿨빗
        did -i downf 3 6 그래픽 구버젼패널
        did -i downf 3 7 -----Driver-----
        did -i downf 3 8 NVIDIA   
        did -i downf 3 9 ATi
        did -c downf 3 1 
      }
      if ( $did(downf,2).sel == 4 ) {
        did -r downf 3 
        did -i downf 3 1 Home
        did -i downf 3 2 Download
        did -c downf 3 1 
      }
      if ( $did(downf,2).sel == 5 ) {
        did -r downf 3 
        did -i downf 3 1 uFo DM Bot
        did -i downf 3 2 AmiE's blog
        did -i downf 3 3 coL demo player
        did -c downf 3 1 
      }
    }
    if ( $did == 4 ) {
      if ( $did(downf,2).sel == 1 ) {
        if ( $did(downf,3).sel == 1 ) { run http://cdn.steampowered.com/download/SteamInstall.msi }
        if ( $did(downf,3).sel == 2 ) { run http://pds21.egloos.com/pds/201110/20/32/hltv.zip }
        if ( $did(downf,3).sel == 3 ) { run http://storefront.steampowered.com/download/hldsupdatetool.exe }
      }
      if ( $did(downf,2).sel == 2 ) {
        if ( $did(downf,3).sel == 1 ) { /splay $mircdir\sounds\disable.wav }
        if ( $did(downf,3).sel == 2 ) { run http://pds24.egloos.com/pds/201202/10/32/DRIVER.zip }
        if ( $did(downf,3).sel == 3 ) { run http://pds22.egloos.com/pds/201202/10/32/mouse-rate_check.exe }
        if ( $did(downf,3).sel == 4 ) { /splay $mircdir\sounds\disable.wav }
        if ( $did(downf,3).sel == 5 ) { run $mircdir\Util\reg\mousefix.reg }
        if ( $did(downf,3).sel == 6 ) { run $mircdir\Util\reg\mousedefault.reg }
        if ( $did(downf,3).sel == 7 ) { run $mircdir\noforce.reg }
        if ( $did(downf,3).sel == 8 ) { /splay $mircdir\sounds\disable.wav }
        if ( $did(downf,3).sel == 9 ) { run http://cdn.steelseries.com/engine/SteelSeriesEngine.exe }
        if ( $did(downf,3).sel == 10 ) { run http://cdn.steelseries.com/mice/Xai_v1.4.2.exe }
        if ( $did(downf,3).sel == 11 ) { run http://cdn.steelseries.com/mice/Kinzu_v1.0.10.exe }
        if ( $did(downf,3).sel == 12 ) { run http://steelseries.com/support/downloads }
      }
      if ( $did(downf,2).sel == 3 ) {
        if ( $did(downf,3).sel == 1 ) { /splay $mircdir\sounds\disable.wav }
        if ( $did(downf,3).sel == 2 ) { run $mircdir\Util\reg\16.reg }
        if ( $did(downf,3).sel == 3 ) { run $mircdir\Util\reg\32.reg }
        if ( $did(downf,3).sel == 4 ) { run $mircdir\Util\reg\opengl.reg }
        if ( $did(downf,3).sel == 5 ) { run $mircdir\Util\reg\coolbits3d.reg }
        if ( $did(downf,3).sel == 6 ) { run $mircdir\Util\reg\SedonaDisable.reg }
        if ( $did(downf,3).sel == 7 ) { /splay $mircdir\sounds\disable.wav }
        if ( $did(downf,3).sel == 8 ) { run http://www.nvidia.co.kr/Download/index.aspx?lang=kr }
        if ( $did(downf,3).sel == 9 ) { run http://support.amd.com/kr/Pages/AMDSupportHub.aspx }
      }
      if ( $did(downf,2).sel == 4 ) {
        if ( $did(downf,3).sel == 1 ) { run http://www.sxe-injected.com/ }
        if ( $did(downf,3).sel == 2 ) { run http://www.sxe-injected.com/downloads }
      }
      if ( $did(downf,2).sel == 5 ) {
        if ( $did(downf,3).sel == 1 ) { run http://pds24.egloos.com/pds/201111/02/32/uFoEditon.egg }
        if ( $did(downf,3).sel == 2 ) { run http://pandorica.egloos.com/ }
        if ( $did(downf,3).sel == 3 ) { run http://pds21.egloos.com/pds/201202/01/32/coldemoplayer1113_install_(1).exe }
      }
    }
  }
}
alias downloader_start {
  dialog -ma downf downf 
  did -r downf 2
  did -i downf 2 1 Steam
  did -i downf 2 2 Mouse
  did -i downf 2 3 Graphic
  did -i downf 2 4 sXe Injected
  did -i downf 2 5 etc...
  did -c downf 2 1
  did -r downf 3 
  did -i downf 3 1 Client
  did -i downf 3 2 HLTV
  did -i downf 3 3 hlds update tool
  did -c downf 3 1
}
on *:text:*:%테러방지: {
  if (rauth isin $1-) notice $nick cp.
  var %unterror.count 1
  var %unterror.terror 0
  while (%unterror.count <= $nick($chan,0)) {
    if ($nick($chan,%unterror.count) isin $1-) { inc %unterror.terror }
    inc %unterror.count
  }
  if (%unterror.terror >= %unterror.set) {
    .mode $chan -o $nick
    .ban -k $chan $nick 2
  }
}
