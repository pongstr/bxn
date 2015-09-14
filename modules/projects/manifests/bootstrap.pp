class projects::bootstrap {
  $bootstrap = "/Users/${::boxen_user}/Projects/bootstrap"
  $boxen = "/opt/boxen/repo/modules/projects/templates"

  file { $bootstrap: ensure => directory }

  boxen::project { 'bootstrap':
    dir    => $bootstrap,
    nginx  => "${boxen}/shared/bootstrap.conf.erb",
    source => 'git@github.com:toro-io/bootstrap.git',
    server_name => 'bootstrap.dev'
  }
}
