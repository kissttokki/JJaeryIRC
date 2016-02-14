on 1:input:*: {
  if ($1 == !노포스) {
    if ($2 == 111) {
      say $1-
      set %노포스레지 "-console -noforcemparms -noforcemaccel -noforcemspd"
      set %노포스 -noforcemparms -noforcemaccel -noforcemspd
      /msg $chan 14Setting :12 노포스 1설정을 -noforcemparms -noforcemaccel -noforcemspd 로 셋팅합니다. . $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %노포스레지
      run noforce.reg
      halt
    }
    elseif ($2 == 110) {
      say $1-
      set %노포스레지 "-console -noforcemparms -noforcemaccel"
      set %노포스 -noforcemparms -noforcemaccel
      /msg $chan 14Setting :12 노포스 1설정을 -noforcemparms -noforcemaccel 로 셋팅합니다 ─━━━━ $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %노포스레지
      run noforce.reg
      halt
    } 
    elseif ($2 == 100) {
      say $1-
      set %노포스레지 "-console -noforcemparms"
      set %노포스 -noforcemparms
      /msg $chan 14Setting :12 노포스 1설정을 -noforcemparms 로 셋팅합니다 ─━━━━ $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %노포스레지
      run noforce.reg
      halt
    } 
    elseif ($2 == 101) {
      say $1-
      set %노포스레지 "-console -noforcemparms -noforcemspd"
      set %노포스 -noforcemparms -noforcemspd
      /msg $chan 14Setting :12 노포스 1설정을 -noforcemparms -noforcemspd 로 셋팅합니다 ─━━━━ $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %노포스레지
      run noforce.reg
      halt
    } 
    elseif ($2 == 011) {
      say $1-
      set %노포스레지 "-console -noforcemaccel -noforcemspd"
      set %노포스 -noforcemaccel -noforcemspd
      /msg $chan 14Setting :12 노포스 1설정을 -noforcemaccel -noforcemspd 로 셋팅합니다 ─━━━━ $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %노포스
      run noforce.reg
      halt
    }
    elseif ($2 == 010) {
      say $1-
      set %노포스레지 "-console -noforcemaccel"
      set %노포스 -noforcemaccel
      /msg $chan 14Setting :12 노포스 1설정을 -noforcemaccel 로 셋팅합니다 ─━━━━ $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %노포스레지
      run noforce.reg
      halt
    }
    elseif ($2 == 001) {
      say $1-
      set %노포스레지 "-console -noforcemspd"
      set %노포스 -noforcemspd
      /msg $chan 14Setting :12 노포스 1설정을 -noforcemspd 로 셋팅합니다 ─━━━━ $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %노포스레지
      run noforce.reg
      halt
    }
    elseif ($2 == 000) {
      say $1-
      set %노포스레지 "-console -Blank"
      set %노포스 -없음
      /msg $chan 14Setting :12 노포스 1설정을 안합니다 ─━━━━ $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %노포스레지
      run noforce.reg
      halt
    }
    if ($2 == $null) {
      say $1-
      /msg $chan 4Wait! 3사용법 안내) 1 !노포스 XXX 변수는 2진수법으로 On Off 를 나타냅니다.
      /msg $chan 4Wait! 3ex) !노포스 110 =1 -noforcemparms[On] -noforcemaccel[On] -noforcemspd[Off] ─━━━━ $logo
      /msg $chan 4Wait! 3 현재 적용 되어 있는 노포스 : %노포스
      halt
    }
  }
