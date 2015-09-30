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
  include brewcask
  include dnsmasq
  include git
  include hub
  include mongodb
  include nginx
  include postgresql
  include python
  include redis
  include virtualbox
  include zsh

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  nodejs::version { '0.12.7': }
  nodejs::version { '4.1.1': }

  # default ruby versions
  ruby::version { '1.9.3': }
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
      'openssl',
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

  $home_directory  = "/Users/${::boxen_user}"
  $custom_dotfiles = "${home_directory}/.dotfiles"
  $custom_projects = "${home_directory}/Projects"

  $node_version = '4.1.1'
  $ruby_version = '2.1.6'

  # NPM Modules
  # -----------
  # Default Mjolnir modules for development and convenience.

  npm_module { 'Bower Browser Package Manager':
    module       => 'bower',
    node_version => $node_version,
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

  npm_module { 'JSCS':
    module       => 'jscs',
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
    ruby_version => $ruby_version,
  }

  ruby_gem { 'jekyll':
    gem          => 'jekyll',
    version      => '~> 2.5.3',
    ruby_version => $ruby_version,
  }

  # !Deprecated since v1.1.0 in place of `libsass` and `sassc`
  ruby_gem { 'sass compass':
    gem          => 'compass',
    version      => '~> 1.0.3',
    ruby_version => $ruby_version,
  }

  ruby_gem { 'foundation cli':
    gem          => 'foundation',
    version      => '~> 1.0.4',
    ruby_version => $ruby_version,
  }

  # Mooooooarrr Customizations
  # --------------------------

  # OhMyZshell
  repository { 'oh-my-zsh':
    path     => "${home_directory}/.oh-my-zsh",
    ensure   => 'origin/master',
    source   => 'robbyrussell/oh-my-zsh',
    force    => true,
    provider => 'git',
  }

  # Ensure Directories
  # ------------------

  # Dotfiles Directory
  file { $custom_dotfiles: ensure => directory }

  # Projects Directory
  file { $custom_projects: ensure => directory }

  # Vim: Initialize Directories
  $vim = [
    "${home_directory}/.vim",
    "${home_directory}/.vim/backups",
    "${home_directory}/.vim/colors",
    "${home_directory}/.vim/swaps",
    "${home_directory}/.vim/undo",
  ]

  # Vim: Create Directories
  file { $vim:
    ensure => directory,
    owner => $boxen_user,
    group => 'staff',
    mode  => '0755',
  }

  # OSX Preferences
  include osx::dock::autohide
  include osx::finder::enable_quicklook_text_selection
  include osx::finder::show_hard_drives_on_desktop
  include osx::global::disable_autocorrect
  include osx::global::expand_save_dialog
  include osx::global::tap_to_click
  include osx::safari::enable_developer_mode

  class { 'osx::dock::icon_size': size => 32 }
  class { 'osx::dock::hot_corners': bottom_right => "Start Screen Saver" }
  class { 'osx::global::key_repeat_rate': rate => 0 }
  class { 'osx::mouse::button_mode': mode => 2 }
  class { 'osx::mouse::swipe_between_pages': enabled => true }


  # Homebrew Packages
  # -----------------
  package {
    'atom':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'cyberduck':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'dashlane':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'diffmerge':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'docker':
      ensure => 'present',
      source => 'homebrew';

    'docker-machine':
      ensure => 'present',
      provider => 'brewcask';

    'docker-compose':
      ensure => 'present',
      provider => 'brewcask';

    'firefox':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'firefoxdeveloperedition':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'google-chrome':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'google-chrome-canary':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'hipchat':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'iterm2':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'kitematic':
      ensure => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'sassc':
      ensure => 'installed',
      source => 'homebrew';

    'sublime-text3':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];

    'vim':
      ensure => 'installed',
      source => 'homebrew',
      install_options => [
        '--override-system-vi'
      ];

    'vlc':
      ensure   => 'present',
      provider => 'brewcask',
      install_options => [
        '--appdir=/Applications'
      ];
  }
}
