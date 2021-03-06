#/environments/windows/modules/jenkins_node_windows/manifests/install.pp

class jenkins_node_windows::install (

  $ant = $jenkins_node_windows::params::ant,
  $chromedriver = $jenkins_node_windows::params::chromedriver,
  $geckodriver = $jenkins_node_windows::params::geckodriver,
  $gpg4win  = $jenkins_node_windows::params::gpg4win,
  $gradle = $jenkins_node_windows::params::gradle,
  $graphviz = $jenkins_node_windows::params::graphviz,
  $iedriver = $jenkins_node_windows::params::iedriver,
  $jdk = $jenkins_node_windows::params::jdk,
  $maven = $jenkins_node_windows::params::maven,
  $nant = $jenkins_node_windows::params::nant,
  $forrest = $jenkins_node_windows::params::forrest,
) {

  include jenkins_node_windows::params
  #### Install winSVN ####
  package { 'CMake':
    ensure => present,
    source => 'c:\temp\cmake-3.16.2-win64-x64.msi',
  }

  #### Install Firefox silently for the system, but only if not already installed
  exec { 'install Firefox' :
    command  => 'powershell.exe c:\temp\Firefox%20Installer.exe -ms',
    creates  => 'C:\Program Files\Mozilla Firefox\firefox.exe',
    provider => powershell,
  }

    #### Install JDK 1.8 silently for the system, but only if C:\Program Files\Java doesn't exist
  exec { 'install jdk' :
    command  => 'powershell.exe c:\temp\asf-build-jdk1.8.0_152.exe /s',
    creates  => 'C:\Program Files\Java\jdk1.8.0_152\bin\java.exe',
    provider => powershell,
  }

  #### Install winSVN ####
  package { 'winsvn':
    ensure => present,
    source => 'c:\temp\Setup-Subversion-1.8.17.msi',
  }

  #### Install Git silently for the system, but only if C:\Program Files\Git doesn't exist
  exec { 'install Git' :
    command  => 'powershell.exe c:\temp\Git-2.14.3-64-bit.exe /SILENT',
    creates  => 'C:\Program Files\Git\git-cmd.exe',
    provider => powershell,
  }

  #### Unzip cygwin into f:\cygwin
  exec { 'extract cygwin64' :
    command  => "powershell.exe Expand-Archive -Force C:\\temp\\cygwin64.zip -DestinationPath F:\\cygwin64",
    creates  => 'F:\Cygwin64\Cygwin.bat',
    provider => powershell,
  }

  ###################### Setup ANT #############################
  define extract_ant($ant_version = $title){
      exec { "extract ${ant_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-${ant_version}.zip -DestinationPath F:\\jenkins\\tools\\ant\\${ant_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\ant\\${ant_version}\\bin\\ant.cmd",
      }
    }

  extract_ant { $ant:}

#################################################################


###################### Setup Chromedriver #############################
  define extract_chromedriver($chromedriver_version = $title){
      exec { "extract ${chromedriver_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-chromedriver-${chromedriver_version}.zip -DestinationPath F:\\jenkins\\tools\\chromedriver\\${chromedriver_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\chromedriver\\${chromedriver_version}\\win32\\chromedriver.exe",
      }
    }

  extract_chromedriver { $chromedriver:}

#################################################################

###################### Setup Geckodriver #############################
  define extract_geckodriver($geckodriver_version = $title){
      exec { "extract ${geckodriver_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-geckodriver-${geckodriver_version}.zip -DestinationPath F:\\jenkins\\tools\\geckodriver\\${geckodriver_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\geckodriver\\${geckodriver_version}\\win64\\geckodriver.exe",
      }
    }

extract_geckodriver { $geckodriver:}

#################################################################

###################### Setup gpg4win #############################
  define extract_gpg4win($gpg4win_version = $title){
      exec { "extract ${gpg4win_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-gpg4win-${gpg4win_version}.zip -DestinationPath F:\\jenkins\\tools\\gpg4win\\${gpg4win_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\gpg4win\\${gpg4win_version}\\bin\\gpg.exe",
      }
    }

extract_gpg4win { $gpg4win:}

#################################################################

###################### Setup Gradle #############################
  define extract_gradle($gradle_version = $title){
      exec { "extract ${gradle_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-gradle-${gradle_version}.zip -DestinationPath F:\\jenkins\\tools\\gradle\\${gradle_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\gradle\\${gradle_version}\\bin\\gradle.bat",
      }
    }

extract_gradle { $gradle:}

###################### Setup Graphviz #############################
  define extract_graphviz($graphviz_version = $title){
      exec { "extract ${graphviz_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-graphviz-${graphviz_version}.zip -DestinationPath F:\\jenkins\\tools\\graphviz\\${graphviz_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\graphviz\\${graphviz_version}\\bin\\gc.exe",
      }
    }

extract_graphviz { $graphviz:}


#################################################################

###################### Setup IEdriver #############################
  define extract_iedriver($iedriver_version = $title){
      exec { "extract ${iedriver_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-iedriver-${iedriver_version}.zip -DestinationPath F:\\jenkins\\tools\\iedriver\\${iedriver_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\iedriver\\${iedriver_version}\\win32\\iedriverserver.exe",
      }
    }

  extract_iedriver { $iedriver:}

#################################################################

###################### Setup JDK #############################
  define extract_jdk($jdk_version = $title){
      exec { "extract ${jdk_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-${jdk_version}.zip -DestinationPath F:\\jenkins\\tools\\java\\${jdk_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\java\\${jdk_version}\\bin\\java.exe",
      }
    }

  extract_jdk { $jdk:}

#################################################################


###################### Setup Maven #############################
  define extract_maven($maven_version = $title){
      exec { "extract ${maven_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-${maven_version}.zip -DestinationPath F:\\jenkins\\tools\\maven\\${maven_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\maven\\${maven_version}\\bin\\mvn",
      }
    }

  extract_maven { $maven:}

#################################################################


###################### Setup nant #############################
  define extract_nant($nant_version = $title){
      exec { "extract ${nant_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-nant-${nant_version}.zip -DestinationPath F:\\jenkins\\tools\\nant\\${nant_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\nant\\${nant_version}\\bin\\nant.exe",
      }
    }

  extract_nant { $nant:}

#################################################################

###################### Setup Forrest #############################
  define extract_forrest($forrest_version = $title){
      exec { "extract ${forrest_version}" :
        command  => "powershell.exe Expand-Archive -Force F:\\tools_zips\\asf-build-forrest-${forrest_version}.zip -DestinationPath F:\\jenkins\\tools\\forrest\\${forrest_version}", # lint:ignore:140chars
        provider => powershell,
        creates  => "F:\\jenkins\\tools\\forrest\\${forrest_version}\\bin\\forrest.bat",
      }
    }

  extract_forrest { $forrest:}

#################################################################
}
