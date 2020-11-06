#/environments/windows/modules/jenkins_node_windows/manifests/init.pp

class jenkins_node_windows (

  $user_password    = '',
  $ant = [],
  $chromedriver = [],
  $geckodriver = [],
  $gpg4win = [],
  $gradle = [],
  $graphviz = [],
  $iedriver = [],
  $jdk = [],
  $maven = [],
  $nant = [],
  $forrest = [],
  $struts2_snapshots_username = '',
  $apache_snapshots_username = '',
  $apache_snapshots_password = '',
  $vmbuild_snapshots_username = '',
  $vmbuild_snapshots_password = '',
) {
  user { 'jenkins':
    ensure   => present,
    comment  => 'non-admin Jenkins account',
    groups   => ['Users', 'Remote Desktop Users'],
    password => $user_password, #password has to meet whatever policy exists or the account doesn't get created with no error
  }

  #### create directories for Jenkins, tools, and such
  file { ['C:\Program Files (x86)\Adobe',
          'F:\Program Files',
          'F:\jenkins',
          'F:\jenkins\tools',
          'F:\jenkins\tools\ant',
          'F:\jenkins\tools\chromedriver',
          'F:\jenkins\tools\geckodriver',
          'F:\jenkins\tools\gpg4win',
          'F:\jenkins\tools\gradle',
          'F:\jenkins\tools\graphviz',
          'F:\jenkins\tools\iedriver',
          'F:\jenkins\tools\java',
          'F:\jenkins\tools\maven',
          'F:\jenkins\tools\nant',
          'F:\jenkins\tools\forrest',
          'F:\tmp',
          'F:\tools_zips']:
    ensure => directory
  }

  include jenkins_node_windows::params

  class {'jenkins_node_windows::download': }
  -> class {'jenkins_node_windows::install': }

################### create symlinks #############################
  exec { 'create symlink for CMake':
    command  => "cmd.exe /c mklink /d \"F:\\Program Files\\CMake\" \"C:\\Program Files\\CMake\"",
    onlyif   => "if (Test-Path 'F:\\Program Files\\CMake') { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for latest Ant':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\ant\\latest \"&\" mklink /d F:\\jenkins\\tools\\ant\\latest F:\\jenkins\\tools\\ant\\apache-ant-1.10.5",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for latest Ant 10':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\ant\\latest1.10 \"&\" mklink /d F:\\jenkins\\tools\\ant\\latest1.10 F:\\jenkins\\tools\\ant\\apache-ant-1.10.5",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for latest Ant 9':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\ant\\latest1.9 \"&\" mklink /d F:\\jenkins\\tools\\ant\\latest1.9 F:\\jenkins\\tools\\ant\\apache-ant-1.9.13",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for latest Maven':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\maven\\latest \"&\" mklink /d F:\\jenkins\\tools\\maven\\latest F:\\jenkins\\tools\\maven\\apache-maven-3.6.3",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for Maven2':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\maven\\latest2 \"&\" mklink /d F:\\jenkins\\tools\\maven\\latest2 F:\\jenkins\\tools\\maven\\apache-maven-2.2.1",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for Maven3':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\maven\\latest3 \"&\" mklink /d F:\\jenkins\\tools\\maven\\latest3 F:\\jenkins\\tools\\maven\\apache-maven-3.6.3",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for latest Forrest':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\forrest\\latest \"&\" mklink /d F:\\jenkins\\tools\\forrest\\latest F:\\jenkins\\tools\\forrest\\0.9",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for latest JDK':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest \"&\" mklink /d F:\\jenkins\\tools\\java\\latest F:\\jenkins\\tools\\java\\jdk9.0.1",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK15':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest15 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest15 F:\\jenkins\\tools\\java\\jdk15-ea+13",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK14':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest14 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest14 F:\\jenkins\\tools\\java\\jdk14-ea+6",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK13':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest13 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest13 F:\\jenkins\\tools\\java\\jdk13-ea+30",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK12':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest12 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest12 F:\\jenkins\\tools\\java\\jdk12-ea+33",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK11':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest11 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest11 F:\\jenkins\\tools\\java\\jdk11-ea+28",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK10':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest10 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest10 F:\\jenkins\\tools\\java\\jdk10_46",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK1.9':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest1.9 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest1.9 F:\\jenkins\\tools\\java\\jdk9.0.1",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK1.8':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest1.8 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest1.8 F:\\jenkins\\tools\\java\\jdk1.8.0_252+b09",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK1.7':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest1.7 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest1.7 F:\\jenkins\\tools\\java\\jdk1.7.0_79-unlimited-security",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK1.6':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest1.6 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest1.6 F:\\jenkins\\tools\\java\\jdk1.6.0_30",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for JDK1.5':
    command  => "cmd /c rmdir F:\\jenkins\\tools\\java\\latest1.5 \"&\" mklink /d F:\\jenkins\\tools\\java\\latest1.5 F:\\jenkins\\tools\\java\\jdk1.5.0_22-64",# lint:ignore:140chars
    onlyif   => "if ((Get-Item F:\\tools_zips).LastWriteTime -lt (Get-Date).AddMinutes(-60)) { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for short path to workspaces':
    command  => "cmd.exe /c mklink /d \"F:\\short\" \"F:\\jenkins\\jenkins-slave\\workspace\"",
    onlyif   => "if (Test-Path 'F:\\short') { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for Git':
    command  => "cmd.exe /c mklink /d \"F:\\Program Files\\Git\" \"C:\\Program Files\\Git\"",
    onlyif   => "if (Test-Path 'F:\\Program Files\\Git') { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for Subversion':
    command  => "cmd.exe /c mklink /d \"F:\\Program Files (x86)\\Subversion\" \"C:\\Program Files (x86)\\Subversion\"",
    onlyif   => "if (Test-Path 'F:\\Program Files (x86)\\Subversion') { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
  exec { 'create symlink for hudson':
    command  => "cmd.exe /c mklink /d \"F:\\hudson\" \"F:\\jenkins\"",
    onlyif   => "if (Test-Path 'F:\\hudson') { exit 1;}  else { exit 0; }",
    provider => powershell,
  }
#################################################################

  registry_value { 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem\LongPathsEnabled':
    ensure => present,
    type   => dword,
    data   =>  1,
  }

  file { 'gitconfig':
    ensure  => present,
    path    => 'C:\\ProgramData\\Git\\config',
    content => template ('jenkins_node_windows/gitconfig.txt.erb'),
  }

  file { 'C:/Users/Jenkins/.m2/settings.xml':
    content => template ('jenkins_node_windows/settings.xml.erb'),
  }

  file { 'C:/Users/Jenkins/.m2/toolchains.xml':
    source => 'puppet:///modules/jenkins_node_windows/toolchains.xml',
  }

  exec { 'set JAVA_HOME':
    command => "c:\Windows\System32\cmd.exe /c setx JAVA_HOME \"F:\\jenkins\\tools\\java\\latest\"",
  }

  #check to see if JNLP agent is connected to jenkins02, if not, start it up
  #exec { 'Auto start agent':
  #  command  => "Start-ScheduledTask \"Jenkins Restart\"",
  #  onlyif   => "if (!(Get-NetTCPConnection -RemotePort 2014 -ErrorAction SilentlyContinue)) { exit 0; }",
  #  provider => powershell,
  #}
}
