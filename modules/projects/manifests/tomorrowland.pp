class projects::tomorrowland {

  $tomorrowland = "coder"
  $boxen = "/opt/boxen/repo/modules/projects/templates"
  $home  = "/Users/${::boxen_user}/Projects"
  $path  = "${home}/${tomorrowland}"

  file { $path: ensure => directory }

  exec { 'CreateSelfSignedCerts':
    command     => "sh ${boxen}/shell/${tomorrowland}.sh",
    onlyif      => ["test ! -d /etc/nginx/ssl"],
    refreshonly => true,
  }

  boxen::project { $tomorrowland:
    dir     => $path,
    mongodb => true,
    nginx   => "$boxen/shared/${tomorrowland}.conf.erb",
    nodejs  => "0.12.7",
    source  => "git@bitbucket.org:torodev/coder.io.git",
  }
}
