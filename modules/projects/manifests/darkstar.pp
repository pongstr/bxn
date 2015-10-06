class projects::darkstar {

  # Project Properties
  $uikit_project = "uikit"
  $uikit_conf = "${boxen::config::home}"
  $uikit_file = "${uikit_conf}/repo/modules/projects/templates"
  $uikit_path = "/Users/${::boxen_user}/Projects/${uikit_project}"

  # Dev Environment Variables
  $uikit_env = "
# UI-Kit Dev Env Variables
export BOXEN_UIKIT_APP_URL=coder.dev
export BOXEN_UIKIT_APP_NAME=coder
export BOXEN_UIKIT_APP_REPO=git@bitbutcket.org:torodev/darkstar.io.git
export BOXEN_UIKIT_APP_PORTS=\"5000 5001 5002 5003 5004\"
export BOXEN_UIKIT_APP_VERSION=2.0.0
export BOXEN_UIKIT_APP_REPO_REF=develop
export BOXEN_UIKIT_MAIL_HOST=smtp.gmail.com
export BOXEN_UIKIT_MAIL_PORT=465
export BOXEN_UIKIT_MAIL_USER=toro.repo@toro.io
export BOXEN_UIKIT_MAIL_PASS=REDACTED
export BOXEN_UIKIT_CDN=rackspace
export BOXEN_UIKIT_CDN_USER=REDACTED
export BOXEN_UIKIT_CDN_APIKEY=REDACTED
export BOXEN_UIKIT_CDN_REGION=ORD
  "

  file { $uikit_path: ensure => 'directory' }

  file { "${uikit_conf}/env.d/110_${uikit_project}.sh":
    content => "$uikit_env",
  }

  boxen::project { $uikit_project:
    dir     => $uikit_path,
    mongodb => true,
    nginx   => "${uikit_file}/shared/$uikit_project.conf.erb",
    nodejs  => "4.1.1",
    source  => "git@bitbucket.org:torodev/darkstar.git",
  }
}
