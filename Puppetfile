# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod "puppet-#{name}", :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.11.0"

# Support for default hiera data in modules

github "module_data", "0.0.4", :repo => "ripienaar/puppet-module-data"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "brewcask",        "0.0.6"
github "dnsmasq",         "2.0.1"
github "foreman",         "1.2.0"
github "gcc",             "3.0.2"
github "git",             "2.7.92"
github "go",              "2.1.0"
github "homebrew",        "2.0.0"
github "hub",             "1.4.1"
github "inifile",         "1.4.1", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",           "1.4.7", :repo => "toro-io/puppet-nginx"
github "nodejs",          "5.0.6", :repo => "toro-io/puppet-nodejs"
github "openssl",         "1.0.0"
github "phantomjs",       "3.0.0"
github "pkgconfig",       "1.0.0"
github "repository",      "2.4.1"
github "ruby",            "8.5.2"
github "stdlib",          "4.7.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",            "1.0.0"
github "xquartz",         "1.2.2", :repo => "toro-io/puppet-xquartz"

#! Deprecated Puppets for for version 1.1.0
# these puppets are apps that can be installed via homebrew and are symlinked,
# and doesn't require environment settings, it would also mean that forked
# puppets will no longer need maintenance everytime the application updates

github "mongodb",         "1.4.1",  :repo => "toro-io/puppet-mongodb"
github "mysql",           "2.1.2"
github "osx",             "2.8.0"
github "python",          "2.0.1"
github "postgresql",      "4.0.1"
github "redis",           "3.2.1",  :repo => "toro-io/puppet-redis"
github "sysctl",          "1.0.1"
github "tunnelblick",     "1.0.8",  :repo => "toro-io/puppet-tunnelblick"
github "vagrant",         "3.3.3"
github "wget",            "1.0.1"
github "virtualbox",      "1.0.14", :repo => "toro-io/puppet-virtualbox"
github "zsh",             "1.0.0"
