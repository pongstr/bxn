class projects::tomorrowland {

  $tomorrowland = "coder"
  $boxen = "/opt/boxen/repo/modules/projects/templates"
  $home  = "/Users/${::boxen_user}/Projects"
  $path  = "${home}/${tomorrowland}"

  file { $path: ensure => directory }

  file { 'Certs Location':
    path   => "${boxen::config::home}/data/nginx/ssl",
    ensure => directory,
  }

  exec { 'CreateSelfSignedCerts':
    command     => "sh ${boxen}/shell/${tomorrowland}.sh",
    creates     => "${boxen::config::home}/data/nginx/ssl/*.dev.crt",
    refreshonly => true,
    onlyif      => [
      "test ! -f ${boxen::config::home}/data/nginx/ssl/*.dev.crt",
    ],
  }

  boxen::project { $tomorrowland:
    dir     => $path,
    mongodb => true,
    nginx   => "$boxen/shared/${tomorrowland}.conf.erb",
    nodejs  => "0.12.7",
    source  => "git@bitbucket.org:torodev/coder.io.git",
  }
}
