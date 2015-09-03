class projects::darkstar {

  $darkstar = "uikit"
  $boxen = "/opt/boxen/repo/modules/projects/templates"
  $home  = "/Users/${::boxen_user}/Projects"
  $path  = "${home}/${darkstar}"

  file { $path: ensure => directory }

  boxen::project { $darkstar:
    dir     => $path,
    mongodb => true,
    nginx   => "${boxen}/shared/${darkstar}.conf.erb",
    nodejs  => "0.12.7",
    source  => "git@bitbucket.org:torodev/darkstar.git",
  }
}
