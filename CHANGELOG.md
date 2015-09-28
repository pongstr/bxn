Bxn Team Mjolnir
===

## [1.1.0-RC2] - Truth of a Madman
### OS X 10.11 Support
**Latest Updates**

- Removed: `puppet-{app_name}`, apps that don't need env settings are now
  installed via Package class, sources depends on where it's available.
- Removed: `boot2docker`, as per vendor notice, it's deprecated and is
  replaced with `Docker-Machine` brewcask provider.
- Updated: Redis `v3.0.4`
- Updated: Node.js `v4.1.1`
- Patched: [#30](https://github.com/toro-io/bxn/issues/30) [#32](https://github.com/toro-io/bxn/issues/32)

**Known issues**

  - `Docker-Machine` installation fails due to the "need of `sudo`" for
    specific casks, a "hacky way" to work around it is to run:
    `while true; do sudo ls -l; sleep 2; done;` before installation begins
    so it keeps sudo session alive and succeed the cask's installation.

## [1.1.0-RC1] - Truth of a Madman
### OS X 10.11 Support
**Overview**
  - OS X 10.11 Compatibility
  - added projects that runs in vms via vagrant
  - updated `oh-my-zsh` installed via Repository class
  - updated all related service files (e.g., Self-Signed Certificates, etc),
    configs are now located in `/opt/boxen/data/`
  - upgraded Gemfile with `boxen 2.8.0`
  - upgraded puppet-homebrew to `2.0.0`
  - upgraded puppet-python to `2.0.1`
  - upgraded mongodb to `3.0.6`, now using the team-maintained
    [puppet-mongodb](https://github.com/TORO-IO/puppet-mongodb)
  - removed atom package installation from `manifests/site.pp` must be declared
    to personal puppet or hiera config.
  - deprecated `puppets-{app_name}` that can be installed from package, which
    lessens maintenance and always kept up-to-date via homebrew.

**Node.js Stuff**
  - Nodejs and Ruby global versions are now declared from `hiera/common.yaml`
  - node-v4.0.0 availability
  - Available nodejs versions: `0.12.7` and `4.0.0` we found that other
    versions previously installed are no longer necessary.

**Ruby Stuff**
  - Available ruby versions: `1.9.3` and `2.1.6` we found that other versions
    previously installed are no longer necessary.
  - bundler installation for all version
  - removed `gem bootstrap-sass`, bootstrap has switched from less to sass,
    we'll be using sass/scss as the default css preprocessor
  - deprecating `gem compass` in place of `libsass` + `sassc`


## [1.0.0] - 2015-09-04: Hammer of the Gods
### Initial Release
  - Now using Boxen `v3.11.0`, same version applied to [upstream repo](https://github.com/boxen/our-boxen).
  - Application puppets are maintained by the team [`puppet-*`](https://github.com/TORO-IO?utf8=✓&query=puppet-).
  - Boxen Web for automated installation. [branch](https://github.com/TORO-IO/bxn/tree/boxen-web) [9f174c6](https://github.com/TORO-IO/bxn/commit/9f174c6c436dad0bec379fcc51bc4aa362e0bff)
  - Boxen Web is restricted to Team Mjolnir only.
