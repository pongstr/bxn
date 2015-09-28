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

  file { "${boxen}/shell/coder.sh":
    ensure => 'present',
    notify => Exec['CoderSSL']
  }

  exec { 'CoderSSL':
    require => File["${boxen}/shell/coder.sh"],
    command => "/bin/bash ${boxen}/shell/coder.sh",
    user => 'root'
  }

  boxen::project { $tomorrowland:
    dir     => $path,
    mongodb => true,
    nginx   => "$boxen/shared/${tomorrowland}.conf.erb",
    nodejs  => "0.12.7",
    source  => "git@bitbucket.org:torodev/coder.io.git",
  }
}
