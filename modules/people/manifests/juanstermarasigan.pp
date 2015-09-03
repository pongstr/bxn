class people::juanstermarasigan {
  require people::pongstr
  require projects::all

  # Java6 is a dependency of Adobe Creative Cloud Applications
  # this may also be installed manually via OSX Updates or a
  # direct download from: https://support.apple.com/kb/DL1572
  package { 'java6':
    ensure   => installed,
    provider => 'brewcask',
  }

  # Adobe Creative Cloud still needs to be installed manually
  # account credential and necessary info also needs to be
  # entered manually
  package { 'adobe-creative-cloud':
    ensure   => installed,
    provider => 'brewcask',
    install_options => [
      '--appdir=/Applications'
    ]
  }
}
