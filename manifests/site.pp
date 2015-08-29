require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::homebrewdir}/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  include atom
  include brewcask
  include chrome
  include cyberduck
  include dashlane
  include dnsmasq
  include firefox
  include git
  include hipchat
  include hub
  include nginx
  include python
  include sublime_text
  include virtualbox
  include vlc
  include zsh

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  nodejs::version { '0.12': }
  nodejs::version { '0.12.5': }
  nodejs::version { '0.12.7': }

  # default ruby versions
  ruby::version { '1.9.3': }
  ruby::version { '2.1.3': }

  # Taps for Homebrew
  homebrew::tap { 'caskroom/versions': }
  homebrew::tap { 'caskroom/fonts': }

  # common, useful packages
  package {
    [
      'ack',
      'aspell',
      'autoconf',
      'automake',
      'findutils',
      'gnu-tar',
      'libmagic',
      'mpssh',
      'wget',
      'unrar'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }

  # #########################################################################
  # Team Mjolnir Customizations
  # #########################################################################

  # MongoDB
  # -------
  # Creates global default Log and Data locations
  # and sets default host and port at the same time
  file { '/opt/boxen/data/mongodb':
    ensure => directory,
  }

  exec { 'Create MongoDB Data Path':
    command => "mkdir -p /opt/boxen/data/mongodb/data",
    creates => "/opt/boxen/data/mongodb/data",
    onlyif  => ["test ! -d /opt/boxen/data/mongodb"],
  }

  exec { 'Create MongoDB Log Path':
    command => "mkdir -p /opt/boxen/data/mongodb/logs",
    creates => "/opt/boxen/data/mongodb/logs",
    onlyif  => ["test ! -d /opt/boxen/data/mongodb"],
  }

  class { 'mongodb':
    host    => '127.0.0.1',
    port    => '27017',
    logdir  => "/opt/boxen/data/mongodb/logs",
    datadir => "/opt/boxen/data/mongodb/data",
  }

  # Node Packages
}
