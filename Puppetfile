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
github "homebrew",        "1.13.0"
github "hub",             "1.4.1"
github "inifile",         "1.4.1", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",           "1.4.7", :repo => "toro-io/puppet-nginx"
github "nodejs",          "5.0.3", :repo => "toro-io/puppet-nodejs"
github "openssl",         "1.0.0"
github "phantomjs",       "3.0.0"
github "pkgconfig",       "1.0.0"
github "repository",      "2.4.1"
github "ruby",            "8.5.2"
github "stdlib",          "4.7.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",            "1.0.0"
github "xquartz",         "1.2.1"

github "atom",            "1.3.0"
github "boot2docker",     "1.0.2", :repo => "toro-io/puppet-boot2docker"
github "chrome",          "1.2.0"
github "cyberduck",       "1.0.2", :repo => "toro-io/puppet-cyberduck"
github "dashlane",        "1.0.2", :repo => "toro-io/puppet-dashlane"
github "diffmerge",       "1.0.0", :repo => "toro-io/puppet-diffmerge"
github "firefox",         "1.2.4", :repo => "toro-io/puppet-firefox"
github "hipchat",         "1.1.4", :repo => "toro-io/puppet-hipchat"
github "iterm2",          "1.2.5"
github "mongodb",         "1.3.4"
github "mysql",           "2.1.2"
github "osx",             "2.8.0"
github "python",          "2.0.0"
github "postgresql",      "4.0.1"
github "redis",           "3.1.0"
github "sublime_text",    "1.1.1", :repo => "toro-io/puppet-sublime_text"
github "tunnelblick",     "1.0.8", :repo => "toro-io/puppet-tunnelblick"
github "vlc",             "1.1.1", :repo => "toro-io/puppet-vlc"
github "virtualbox",      "1.0.13"
github "wget",            "1.0.1"
github "zsh",             "1.0.0"

