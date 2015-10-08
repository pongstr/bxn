class projects::tomorrowland {

  # Project Properties
  $coder_project = "coder"
  $coder_conf = "${boxen::config::home}"
  $coder_file = "${coder_conf}/repo/modules/projects/templates"
  $coder_path = "/Users/${::boxen_user}/Projects/${coder_project}"

  # Dev Environment Variables
  $coder_env = "
# Coder Dev Env Variables
export BOXEN_CODER_APP_URL=coder.dev
export BOXEN_CODER_APP_NAME=coder
export BOXEN_CODER_APP_REPO=git@bitbutcket.org:torodev/coder.io.git
export BOXEN_CODER_APP_PORTS=\"5000 5001 5002 5003 5004\"
export BOXEN_CODER_APP_VERSION=2.0.0
export BOXEN_CODER_APP_REPO_REF=develop
export BOXEN_CODER_MAIL_HOST=smtp.gmail.com
export BOXEN_CODER_MAIL_PORT=465
export BOXEN_CODER_MAIL_USER=noreply.coder@toro.io
export BOXEN_CODER_MAIL_PASS=REDACTED
export BOXEN_CODER_CDN=rackspace
export BOXEN_CODER_CDN_USER=REDACTED
export BOXEN_CODER_CDN_APIKEY=REDACTED
export BOXEN_CODER_CDN_REGION=DFW
  "

  file { $coder_path: ensure => 'directory' }

  file { 'Certificate Paths':
    path   => "${coder_conf}/data/nginx/ssl",
    ensure => 'directory'
  }

  file { "${coder_conf}/env.d/100_${coder_project}.sh":
    content => "$coder_env",
  }

  file { "${coder_file}/shell/${coder_project}.sh":
    ensure => 'present',
    notify => Exec['CreateCoderSSL']
  }

  exec { 'CreateCoderSSL':
    user    => 'root',
    require => File["${coder_file}/shell/${coder_project}.sh"],
    command => "/bin/bash ${coder_file}/shell/${coder_project}.sh",
  }

  boxen::project { $coder_project:
    dir     => $coder_path,
    mongodb => true,
    nginx   => "${coder_file}/shared/$coder_project.conf.erb",
    nodejs  => "0.12.7",
    source  => "git@bitbucket.org:torodev/coder.io.git",
  }
}
