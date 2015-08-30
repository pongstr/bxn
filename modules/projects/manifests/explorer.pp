class projects::explorer {

  $projects = "/Users/${::boxen_user}/BoxenProjects"
  $explorer = "${projects}/explorer"

  file { $projects: ensure => directory }
  file { $explorer: ensure => directory }

  boxen::project { 'explorer':
    dir    => "${explorer}",
    nodejs => '0.12.7',
    nginx  => true,
    source => 'git@bitbucket.org:torodev/toro-explorer.git'
  }
}
