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
  include chrome::canary
  include cyberduck
  include dashlane
  include dnsmasq
  include firefox
  include firefox::aurora
  include git
  include hipchat
  include hub
  include mongodb
  include nginx
  include python
  include redis
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
  ruby::version { '2.1.6': }

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

  $home_directory = "/Users/${::boxen_user}"
  $node_version   = '0.12.7'
  $ruby_version   = '2.1.6'

  # MongoDB
  # -------
  # Creates global default Log and Data locations
  # and sets default host and port at the same time
  # file { "/opt/boxen/data/mongodb":
  #   ensure => directory,
  # }

  # NPM Modules
  # -----------
  # Default Mjolnir modules for development and convenience.
  npm_module { 'Bower Browser Package Manager':
    module       => 'bower',
    node_version => '*',
  }

  npm_module { 'CoffeeScript':
    module       => 'coffee-script',
    node_version => $node_version,
  }

  npm_module { 'ExpressJS':
    module       => 'express',
    node_version => $node_version,
  }

  npm_module { 'Grunt CLI':
    module       => 'grunt-cli',
    node_version => $node_version,
  }

  npm_module { 'Gulp Build System':
    module       => 'gulp',
    node_version => $node_version,
  }

  npm_module { 'JSHint':
    module       => 'jshint',
    node_version => $node_version,
  }

  npm_module { 'Karma CLI':
    module       => 'karma-cli',
    node_version => $node_version,
  }

  npm_module { 'Less Leaner CSS':
    module       => 'less',
    node_version => $node_version,
  }

  npm_module { 'Strongloop CLI':
    module       => 'strongloop',
    node_version => $node_version,
  }

  npm_module { 'Mongoose':
    module       => 'mongoose',
    node_version => $node_version,
  }

  npm_module { 'Nodemon':
    module       => 'nodemon',
    node_version => $node_version,
  }

  npm_module { 'PM2':
    module       => 'pm2',
    node_version => $node_version,
  }

  npm_module { 'Sails.js':
    module       => 'sails',
    node_version => $node_version,
  }

  npm_module { 'Shelljs':
    module       => 'shelljs',
    node_version => $node_version,
  }

  # Ruby Gems
  # ---------
  # Default Mjolnir gems for development and convenience.
  ruby_gem { 'bundler for all rubies':
    gem          => 'bundler',
    version      => '~> 1.10.6',
    ruby_version => '*',
  }

  ruby_gem { 'bootstrap sass':
    gem          => 'bootstrap-sass',
    version      => '~> 3.3.5',
    ruby_version => $ruby_version,
  }

  ruby_gem { 'sass compass':
    gem          => 'compass',
    version      => '~> 1.0.3',
    ruby_version => $ruby_version,
  }

  ruby_gem { 'zurb foundation':
    gem          => 'foundation',
    version      => '~> 1.0.4',
    ruby_version => $ruby_version,
  }

  ruby_gem { 'github-pages':
    gem          => 'github-pages',
    version => '~> 39',
    ruby_version => $ruby_version,
  }


  # RoboMongo
  package { 'robomongo':
    provider => 'brewcask',
    ensure   => installed,
  }

  # Oh-My-ZSH
  file { "${home_directory}/.oh-my-zsh":
    ensure => directory,
  }

  exec { 'install oh-my-zsh plugin':
    command => "curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh",
    onlyif => [
      "test ! -d ${home_directory}/.oh-my-zsh"
    ]
  }
}
