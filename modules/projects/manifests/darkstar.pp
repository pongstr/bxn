class projects::darkstar {

  $darkstar = "uikit"
  $home     = "/Users/${::boxen_user}/Projects"
  $path     = "${home}/${name}"
  $boxn     = "/opt/boxen/repo/modules/projects/templates"

  file { $path: ensure => directory }

  boxen::project { $darkstar:
    dir     => $path,
    mongodb => true,
    nginx   => "${boxn}/shared/${darkstar}.conf.erb",
    nodejs  => "0.12.7",
    source  => "git@bitbucket.org:torodev/darkstar.git",
  }
}
