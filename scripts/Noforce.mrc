on 1:input:*: {
  if ($1 == !������) {
    if ($2 == 111) {
      say $1-
      set %���������� "-console -noforcemparms -noforcemaccel -noforcemspd"
      set %������ -noforcemparms -noforcemaccel -noforcemspd
      /msg $chan 14Setting :12 ������ 1������ -noforcemparms -noforcemaccel -noforcemspd �� �����մϴ�. . $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %����������
      run noforce.reg
      halt
    }
    elseif ($2 == 110) {
      say $1-
      set %���������� "-console -noforcemparms -noforcemaccel"
      set %������ -noforcemparms -noforcemaccel
      /msg $chan 14Setting :12 ������ 1������ -noforcemparms -noforcemaccel �� �����մϴ� ���������� $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %����������
      run noforce.reg
      halt
    } 
    elseif ($2 == 100) {
      say $1-
      set %���������� "-console -noforcemparms"
      set %������ -noforcemparms
      /msg $chan 14Setting :12 ������ 1������ -noforcemparms �� �����մϴ� ���������� $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %����������
      run noforce.reg
      halt
    } 
    elseif ($2 == 101) {
      say $1-
      set %���������� "-console -noforcemparms -noforcemspd"
      set %������ -noforcemparms -noforcemspd
      /msg $chan 14Setting :12 ������ 1������ -noforcemparms -noforcemspd �� �����մϴ� ���������� $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %����������
      run noforce.reg
      halt
    } 
    elseif ($2 == 011) {
      say $1-
      set %���������� "-console -noforcemaccel -noforcemspd"
      set %������ -noforcemaccel -noforcemspd
      /msg $chan 14Setting :12 ������ 1������ -noforcemaccel -noforcemspd �� �����մϴ� ���������� $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %������
      run noforce.reg
      halt
    }
    elseif ($2 == 010) {
      say $1-
      set %���������� "-console -noforcemaccel"
      set %������ -noforcemaccel
      /msg $chan 14Setting :12 ������ 1������ -noforcemaccel �� �����մϴ� ���������� $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %����������
      run noforce.reg
      halt
    }
    elseif ($2 == 001) {
      say $1-
      set %���������� "-console -noforcemspd"
      set %������ -noforcemspd
      /msg $chan 14Setting :12 ������ 1������ -noforcemspd �� �����մϴ� ���������� $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %����������
      run noforce.reg
      halt
    }
    elseif ($2 == 000) {
      say $1-
      set %���������� "-console -Blank"
      set %������ -����
      /msg $chan 14Setting :12 ������ 1������ ���մϴ� ���������� $logo
      writeini noforce.reg HKEY_CURRENT_USER\Software\Valve\Steam\Apps\10 "LaunchOptions" %����������
      run noforce.reg
      halt
    }
    if ($2 == $null) {
      say $1-
      /msg $chan 4Wait! 3���� �ȳ�) 1 !������ XXX ������ 2���������� On Off �� ��Ÿ���ϴ�.
      /msg $chan 4Wait! 3ex) !������ 110 =1 -noforcemparms[On] -noforcemaccel[On] -noforcemspd[Off] ���������� $logo
      /msg $chan 4Wait! 3 ���� ���� �Ǿ� �ִ� ������ : %������
      halt
    }
  }
