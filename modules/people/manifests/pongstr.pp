class people::pongstr {

  notify { "Hello ${::boxen_user}, Let's get you bootstrapped.": }
  notify { "We're now going to run the setup to make you feel at home.": }

  $home_directory  = "/Users/${::boxen_user}"
  $custom_dotfiles = "${home_directory}/.dotfiles"
  $custom_projects = "${home_directory}/Projects"
  $custom_packages = "${home_directory}/Library/Application Support/Sublime Text 3/"

  file { "${custom_packages}/Packages/User":
    ensure => directory,
    require => Package['sublime-text3'],
  }

  # Pongstr Dotfiles
  repository { $custom_dotfiles:
    path     => $custom_dotfiles,
    ensure   => 'origin/master',
    source   => 'pongstr/dotfiles',
    force    => true,
    provider => 'git',
  }

  # Pongstr Spacegray Theme
  repository { $custom_packages:
    path     => "${custom_packages}/Packages/Theme - Spacegray",
    ensure   => 'origin/master',
    source   => 'pongstr/spacegray',
    force    => true,
    provider => 'git',
  }

  # Vim: Link .vimrc from pongstr/dotfiles
  file { "${home_directory}/.vimrc":
    mode   => '0644',
    owner  => $boxen_user,
    ensure => link,
    target => "${custom_dotfiles}/bin/vim/.vimrc",
  }

  # Vim: Link Pongstr Base-16 theme
  file { "${home_directory}/.vim/colors/Pongstr Base-16.vim":
    mode    => '0644',
    owner   => $boxen_user,
    ensure  => link,
    target  => "${custom_dotfiles}/bin/vim/Pongstr Base-16.vim",
    require => Repository[$custom_dotfiles],
  }

  # Zsh: Link .zshrc settings
  file { "${home_directory}/.zshrc":
    mode    => '0755',
    owner   => $boxen_user,
    ensure  => link,
    target  => "${custom_dotfiles}/bin/shell/.zshrc",
    require => Repository[$custom_dotfiles],
  }

  file { "${home_directory}/.oh-my-zsh/themes":
    ensure => directory
  }

  # Zsh: Link Zsh Pongstr Base-16 Theme
  file { "${home_directory}/.oh-my-zsh/themes/pongstr.zsh-theme":
    mode    => '0755',
    ensure  => link,
    target  => "${custom_dotfiles}/bin/shell/Pongstr Base-16.zsh-theme",
    require => Repository['oh-my-zsh'],
  }

  # Sublime Text 3 Settings
  # ---------------------

  # Preferences
  file { "${custom_packages}/Packages/User/Preferences.sublime-settings":
    mode    => '0755',
    group   => 'staff',
    owner   => $boxen_user,
    ensure  => present,
    source  => "${custom_dotfiles}/bin/subl/Preferences.sublime-settings",
    require => File["${custom_packages}/Packages/User"],
  }

  # Keymaps
  file { "${custom_packages}/Packages/User/Default (OSX).sublime-keymap":
    mode    => '0755',
    group   => 'staff',
    owner   => $boxen_user,
    ensure  => present,
    source  => "${custom_dotfiles}/bin/subl/Default (OSX).sublime-keymap",
    require => File["${custom_packages}/Packages/User"],
  }

  # Sublime Text Packages
  file { "${custom_packages}/Packages/User/Package Control.sublime-settings":
    mode    => '0755',
    group   => 'staff',
    owner   => $boxen_user,
    ensure  => present,
    source  => "${custom_dotfiles}/bin/subl/Package Control.sublime-settings",
    require => File["${custom_packages}/Packages/User"],
  }

  # Package Control
  $package_control = "https://packagecontrol.io/Package%20Control.sublime-package"

  exec { 'Package Control':
    command => "wget --directory-prefix=\"${custom_packages}Installed Packages\" ${package_control}",
  }

  include projects::all
}
